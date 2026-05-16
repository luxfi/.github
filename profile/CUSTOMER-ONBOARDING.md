# Lux Commercial Customer Onboarding

How a customer who has signed a Lux Industries commercial license goes from
PO-signed to running a GPU-accelerated `cevm-gpu` node, the proprietary
DEX matching engine, or programming an FPGA bitstream.

This document is the **operator runbook** for the Lux side of the handoff
and the **install instructions** for the customer side. It is the only
place these instructions live; any other copy is a leak.

---

## 0. What the customer is buying

The OSS distributions of `luxfi/evm`, `luxfi/cevm`, `luxfi/dex`, and
`luxfi/fpga` are fully functional on CPU paths and contain no shimmed-out
code. Each binary calls `license.HasFeatureOrDie("<scope>")` at the
entry point of its commercial code path; without a valid token bearing
the scope, the commercial path refuses to start and a clear stderr
message points the operator at this document.

Commercial code paths live in `lux-private/*`:

| Repo | Scope | Channel | Artifact tag |
|------|-------|---------|--------------|
| `lux-private/gpu-kernels` | `gpu`, `cuda`, `fhe-mlx` | `oras` OCI artifact | `ghcr.io/lux-private/gpu-kernels:<vX>` |
| `lux-private/dex` | `dex` | Docker runtime image | `ghcr.io/lux-private/dex:<vX>` |
| `lux-private/fpga` | `fpga` | `oras` OCI artifact | `ghcr.io/lux-private/fpga-bitstreams:<vX>` |
| `luxcpp/cevm` (`cevm-gpu`) | `gpu` | Docker runtime image | `ghcr.io/lux-private/cevm-gpu:<vX>` |

The license token format and verification library are open source under
`luxfi/license` (BSD-3-Clause). Possessing the library grants no
commercial rights; only a token signed by the Lux Industries production
key does.

---

## 1. Operator side: issue the customer's credentials

Performed by a Lux Industries operator with access to the production
signing key and the `lux-private` org admin.

### 1.1 Issue the license token

Production signing key lives in the Lux KMS (`~/work/lux/kms`) under
project `lux-license` and is never written to disk. Issuance happens
inside a short-lived KMS sign session.

```bash
lux-license issue \
    --customer "Acme Inc" \
    --license-id "lic_acme_2026q2" \
    --expiry 2027-04-01 \
    --scope gpu,dex,fpga,fhe-mlx \
    --features tier=enterprise,max_nodes=50,support=24x7 \
    --notes "Order #SO-2026-0042, MSA dated 2026-04-01" \
    --kms-key lux-license/prod \
    > out/acme-license.jwt
```

For dev/test only:

```bash
lux-license issue --dev --customer "Acme Inc" --scope gpu > out/acme-dev.jwt
```

The `--dev` flag uses the embedded development key and produces tokens
that any unmodified Lux binary will accept with a one-time stderr
warning. Production tokens are silent on success.

> **Pending**: the production signing key has not been generated yet.
> All tokens issued today use the dev key. The production-key generation
> ceremony is tracked in `lux-private/operator-runbooks#1`.

### 1.2 Add the customer to the lux-private/customers GitHub team

The pull credential for `ghcr.io/lux-private/*` is membership in a
read-only team scoped to the customer's deployment.

```bash
HANZO_TOKEN=$(env -u GH_TOKEN gh auth token --user hanzo-dev)
GH_TOKEN=$HANZO_TOKEN gh api -X PUT \
    /orgs/lux-private/teams/customers-acme/memberships/<customer-github-username> \
    -f role=member
```

Team `customers-<slug>` has `read` permission on exactly the repos
covered by the license scopes. For example, a customer with
`scope=gpu,dex` gets `read` on `lux-private/gpu-kernels` and
`lux-private/dex` but not `lux-private/fpga`.

### 1.3 Hand off

The customer receives, over a channel agreed in the MSA (signed email
or shared Vault item):

1. The license token file `acme-license.jwt`.
2. The name of their GitHub team and a link to accept the invitation.
3. A link to this document.

Total artifacts to hand off: **one JWT file + one team invite**. No
keys, no shared passwords, no installer.

---

## 2. Customer side: install and run

### 2.1 Install the license token

Place the JWT where the binary will discover it:

```bash
mkdir -p ~/.lux
mv acme-license.jwt ~/.lux/license.jwt
chmod 600 ~/.lux/license.jwt
```

Discovery order (matches `luxfi/license`):

1. `$LUX_LICENSE` — base64 token in the env directly
2. `$LUX_LICENSE_FILE` — path to a token file
3. `~/.lux/license.jwt`
4. `~/.lux/license`

For container runtimes, the conventional pattern is to mount the file
read-only and set `LUX_LICENSE_FILE`:

```bash
docker run \
    -v $HOME/.lux/license.jwt:/etc/lux/license.jwt:ro \
    -e LUX_LICENSE_FILE=/etc/lux/license.jwt \
    ghcr.io/lux-private/cevm-gpu:v0.50.0
```

### 2.2 Authenticate to GHCR

After accepting the GitHub team invitation, generate a fine-grained PAT
scoped to read packages from `lux-private/*`:

1. Go to https://github.com/settings/personal-access-tokens/new
2. Resource owner: `lux-private`
3. Repository access: All repositories
4. Permissions: `Repository permissions -> Contents: Read`, `Packages: Read`
5. Save the token as `GHCR_PAT`

```bash
echo $GHCR_PAT | docker login ghcr.io -u <your-github-username> --password-stdin
```

For Kubernetes, the same PAT goes into a regcred Secret. The IAM team's
template for that lives in `~/work/lux/universe/k8s/templates/regcred-ghcr.yaml`.

### 2.3 Pull and run

#### cevm-gpu

```bash
docker pull ghcr.io/lux-private/cevm-gpu:v0.50.0

docker run \
    --gpus all \
    -v $HOME/.lux/license.jwt:/etc/lux/license.jwt:ro \
    -e LUX_LICENSE_FILE=/etc/lux/license.jwt \
    -p 9650:9650 \
    ghcr.io/lux-private/cevm-gpu:v0.50.0
```

On startup the binary calls `license.HasFeatureOrDie("gpu")`. Successful
verification is silent; failure prints the cause (`ErrExpired`,
`ErrBadSig`, missing scope, etc.) and exits with code 1.

#### Lux DEX matching engine

```bash
docker pull ghcr.io/lux-private/dex:v0.50.0

docker run \
    -v $HOME/.lux/license.jwt:/etc/lux/license.jwt:ro \
    -e LUX_LICENSE_FILE=/etc/lux/license.jwt \
    -p 8080:8080 \
    ghcr.io/lux-private/dex:v0.50.0
```

The gate `lx.EnforceMatchingEngineLicense()` is the first statement of
`cmd/dex-server/main.go` — the process either passes the check
silently or refuses to construct any matcher state.

#### GPU kernel libraries (linked into your own cevm build)

```bash
oras pull ghcr.io/lux-private/gpu-kernels:v0.1.0-linux-x86_64-cuda
tar -xzf lux-gpu-kernels-v0.1.0-linux-x86_64-cuda.tar.gz -C /opt/lux/gpu-kernels
```

Then in your CMake build:

```cmake
list(APPEND CMAKE_PREFIX_PATH /opt/lux/gpu-kernels)
find_package(lux-gpu-kernels CONFIG REQUIRED)
target_link_libraries(my_app PRIVATE lux::gpu-kernels)
```

#### FPGA bitstreams

```bash
oras pull ghcr.io/lux-private/fpga-bitstreams:v0.1.0
tar -xzf lux-fpga-v0.1.0.tar.gz -C /opt/lux/fpga
```

The bundle contains both the bitstream files (`.bit`/`.bin`) and the
Go SDK that programs them. The SDK calls
`license.HasFeatureOrDie("fpga")` before opening the device node.

---

## 3. Renewal, revocation, transfer

### Renewal

Issue a new token with a later `Expiry`. Token discovery is single-shot
at process start; rolling restart picks up the new file. There is no
phone-home, no countdown banner, no grace period.

### Revocation

Revocation is not in-band (tokens are offline-verifiable). The contract
remedy is the MSA's termination clause. The technical lever for a
revoked customer is removing them from the `customers-<slug>` GitHub
team, which immediately stops them from pulling new releases of any
private image.

### Transfer / re-key

Treat as revoke + re-issue. Bump the customer's `LicenseID` to a new
value so audit logs can distinguish the new token from the old.

---

## 4. Open questions tracked elsewhere

1. **Production signing key**: not yet generated. The key-gen ceremony,
   custody plan, and rotation policy are in `lux-private/operator-runbooks#1`.
2. **First real customer**: no customer has yet been issued a
   production token. The first sale will exercise this runbook end to
   end and pull request any rough edges back into this document.
3. **ARC runners**: the `lux-private` org has no self-hosted ARC scale
   set today; release workflows run on GitHub-hosted runners. We do not
   propose adding a `lux-private` scale set until artifact volume forces
   it — running customer-bearing release workflows on shared
   infrastructure is the wrong tradeoff while volume is low.
