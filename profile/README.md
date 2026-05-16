# Lux Network

Post-quantum blockchain with multi-consensus architecture, fully homomorphic encryption (FHE), and cross-chain interoperability. High-performance decentralized infrastructure for the next generation of secure, scalable applications.

Lux features the Quasar consensus family, multi-chain architecture (X-Chain DAG, P-Chain platform, C-Chain EVM, custom subnets), and an integrated post-quantum cryptography stack including lattice-based signatures, FHE, and threshold MPC.

## Quick Start

```bash
# Install Lux CLI
go install github.com/luxfi/cli@latest

# Create a local network
lux network start

# Deploy a chain
lux chain create L1
lux chain deploy L1
```

## Architecture

```
Chains:     X-Chain (DAG)  |  P-Chain (Platform)  |  C-Chain (EVM)  |  Subnets
                           |
Consensus:  Quasar Family -- Snowball, Snowflake, Avalanche, Frosty, P3Q
                           |
Crypto:     Lattice signatures  |  FHE  |  Threshold MPC  |  Zero-knowledge
                           |
Bridge:     Teleport -- Zero-knowledge MPC cross-chain bridge
```

## IP and Licensing Strategy

Lux ships a deliberate three-tier IP strategy: **public BSD-3 commodity**,
**patent-protected Lux Ecosystem License with paid commercial license
available**, and a **closed-source private performance tier** living in
`lux-private/*` (private GitHub org). Read this section before forking,
embedding, or building a commercial product on top of Lux code.

### The three tiers

| Tier | Visibility | License | Who can use freely | What lives there |
|------|------------|---------|--------------------|------------------|
| **Public** | `github.com/luxfi/*` (public) | BSD-3-Clause (and a few inherited Apache-2.0 / MIT / GPL / LGPL / MPL / BSL repos — see classification table below) | Anyone, any purpose, including commercial forks | Pure-Go reference implementations. Protocol specs. Types and codecs. Commodity primitives that have no patent claim. |
| **Patent-protected** | `github.com/luxfi/*` (public) | Lux Ecosystem License v1.2 (Eco), or Lux Research License with Patent Reservation, or Lux Genesis License | Authorized Networks (Lux Primary NetID=1 and EVM 96369; official Lux testnets and devnets; Descending Chains) and Research Use | FHE design and runtime, DEX matching engine, novel post-quantum cryptography (lamport, lattice, ringtail, threshold MPC), KMS, MPC, bridge, consensus internals. Source visible (so prior art is established and forks for Authorized Networks are unblocked); commercial use outside Authorized Networks gated. |
| **Private performance moat** | `github.com/lux-private/*` (private org, not on public GitHub) | Commercial license / NDA only | Lux Industries Inc. and paying customers under contract | Production-grade C++ / CUDA / Metal / MLX / FPGA implementations of the same algorithms — the actual performance you cannot get from the public reference. Currently being extracted from `luxcpp/*` (see "Extraction status" below). |

Definitions of "Authorized Network", "Descending Chain", "Research Use",
and "Commercial Use" are the ones in the **Lux Ecosystem License v1.2**
text — see any Eco-tier repo's `LICENSE` for the binding language. Where
this README and the LICENSE disagree, the LICENSE wins.

### Runtime gate vs license tier

A common point of confusion: **every Lux artifact is licensed**. The
question is not "is there a license" — it is "which license, and is
there a runtime token check on top of it". The table below separates
those two concerns.

| Layer | Code license | Runtime token? | Enforcement model |
|-------|--------------|----------------|-------------------|
| BSD-3-Clause commodity | BSD 3-Clause (or inherited Apache-2.0 / MIT / GPL / LGPL / MPL / BSL where vendored) | None | Permissive open source; commercial use and forks unrestricted under the named license. |
| Patent-protected source-visible (Eco) | Lux Ecosystem License v1.2, Lux Research with Patent Reservation, or Lux Genesis License | None | Contract-only — source is visible so prior art is fixed and Authorized Networks can fork; commercial use outside Authorized Networks legally requires a signed paid license (Confluent Server / MongoDB SSPL pattern). |
| Closed performance moat | Commercial License Only (`lux-private/*`, not on public GitHub) | **`luxfi/license` token verified at startup** | Fail-closed runtime check (HashiCorp Vault EE / NVIDIA cuDNN pattern) — token signed by Lux Industries Inc., verified offline against an embedded public key. No phone-home. |

Two things this table makes explicit:

1. **The public CPU binary is not "unlicensed"**. It ships under
   BSD-3-Clause (or, for vendored upstreams, the inherited Apache /
   MIT / GPL / LGPL / MPL / BSL). What it lacks is a runtime token
   check, because there is nothing in that binary to gate.
2. **The runtime token gate at `cevm v0.50.0` and later only fires on
   tier-3 GPU/FPGA backends**. CPU paths run unmodified under their
   actual public licenses. Removing or bypassing the token does not
   make the closed code free — the closed code never shipped in the
   public binary in the first place (two-binary distribution).

### What this strategy is and is not

| | |
|---|---|
| **The Eco tier is the revenue surface.** | Patent-protected repos stay Eco. They are the catalog Lux sells commercial licenses against. There are **no planned license flips from Eco to BSD-3** — loosening the patent gate would erase the licensing business. |
| **The BSD-3 tier is the integration surface.** | If a primitive has no patent claim and no defensible moat, it ships BSD-3. Anyone can fork it, embed it in a sovereign L1, sell a product built on it. This is intentional. It is what makes Lux usable as a base for other networks. |
| **The private moat is the performance surface.** | The C++/CUDA/Metal/MLX/FPGA kernels that make Lux fast (orders of magnitude over the public Go reference) live in `lux-private/*`. Public Go is correct, audited, complete, and slower. The private moat is the same algorithms, hand-tuned for hardware. Contact `licensing@lux.network`. |

### What you can do without a commercial license

| You are | Doing this | Outcome |
|---------|------------|---------|
| Researcher / academic | Anything, any tier | Free under "Research Use" in the Lux Ecosystem License |
| Hobbyist / personal | Anything in the public + patent-protected tiers | Free; Eco permits personal and non-commercial use |
| Commercial product | Building on a Descending Chain (subnet of Lux Primary or downstream) | Free; you are an Authorized Network under Eco |
| Commercial product | Forking BSD-3 code into a sovereign L1 unrelated to Lux | Free; BSD-3 is unrestricted |
| Commercial product | Embedding Eco-tier code (FHE, DEX matching, MPC, threshold, ringtail, lattice, lamport, etc.) in a sovereign L1 unrelated to Lux | Commercial license required — `licensing@lux.network` |
| Commercial product | Using the private moat (C++/CUDA/Metal/MLX/FPGA kernels) | Contract via `licensing@lux.network` |

### Repository classification

The table below mirrors the `LICENSE` file currently in each public
repository. The `LICENSE` file is the binding artifact; this table
is a navigational aid.

| Repository | License | Tier |
|------------|---------|------|
| accel | BSD-3-Clause | Public |
| address | BSD-3-Clause | Public |
| adx | All Rights Reserved (Lux Industries Inc. + ADXYZ Inc.) | Patent-protected |
| age | BSD-3-Clause (vendored from `filippo.io/age`) | Public |
| ai | Lux Ecosystem v1.2 | Patent-protected |
| api | BSD-3-Clause | Public |
| assets | MIT | Public |
| audio | BSD (Lux Audio LLC) | Public |
| benchlist | BSD-3-Clause | Public |
| bft | BSD-3-Clause | Public |
| brand | BSD-3-Clause | Public |
| bridge | Lux Ecosystem v1.2 | Patent-protected |
| build | BSD-3-Clause | Public |
| cache | BSD-3-Clause | Public |
| charts | BSD-3-Clause | Public |
| chat | Apache-2.0 | Public |
| cli | BSD-3-Clause | Public |
| codec | BSD-3-Clause | Public |
| compress | BSD-3-Clause | Public |
| concurrent | BSD-3-Clause | Public |
| config | BSD-3-Clause | Public |
| consensus | Lux Ecosystem v1.2 | Patent-protected |
| constants | BSD-3-Clause | Public |
| container | BSD-3-Clause | Public |
| contracts | BSD-3-Clause | Public |
| coreth | LGPL-3.0 (inherited from go-ethereum) | Public, copyleft |
| corona | Lux Ecosystem v1.2 | Patent-protected |
| crypto | Lux Ecosystem v1.2 | Patent-protected |
| czmq | MPL-2.0 (vendored upstream) | Public, weak copyleft |
| dao | Lux Research with Patent Reservation | Patent-protected |
| database | BSD-3-Clause | Public |
| devops | BSD-3-Clause | Public |
| dex | Lux Research with Patent Reservation | Patent-protected (extraction-pending to `lux-private/*`) |
| docs | BSD-3-Clause | Public |
| docs-template | BSD-3-Clause | Public |
| dwallet | MIT (vendored from Rabby) | Public |
| erc20-go | BSD-3-Clause | Public |
| evm | LGPL-3.0 (inherited from go-ethereum) | Public, copyleft |
| evmgpu | LGPL-3.0 (inherited from go-ethereum) | Public, copyleft |
| exchange | Lux Ecosystem v1.2 | Patent-protected |
| explore | GPL-3.0 (inherited from Blockscout) | Public, copyleft |
| extension | BSD-3-Clause | Public |
| faucet | BSD-3-Clause | Public |
| fhe | Lux Ecosystem v1.2 | Patent-protected |
| fhe-coprocessor | Lux Ecosystem v1.2 | Patent-protected |
| filesystem | BSD-3-Clause | Public |
| financial | All Rights Reserved (Lux Industries Inc.) | Patent-protected |
| formatting | BSD-3-Clause | Public |
| forum | BSD-3-Clause | Public |
| fpga | Lux Ecosystem v1.2 | Patent-protected (extraction-pending to `lux-private/*`) |
| genesis | BSD-3-Clause | Public |
| geth | BSD-3-Clause (Lux fork) | Public |
| go-bip32 | BSD-3-Clause | Public |
| go-bip39 | BSD-3-Clause | Public |
| go-verkle | Public Domain (Unlicense, vendored upstream) | Public |
| gui | MIT | Public |
| header | BSD-3-Clause | Public |
| help | BSD-3-Clause | Public |
| iam | Apache-2.0 | Public |
| ids | BSD-3-Clause | Public |
| indexer | MIT | Public |
| js | BSD-3-Clause | Public |
| keychain | BSD-3-Clause | Public |
| keys | BSD-3-Clause | Public |
| kit | BSD-3-Clause | Public |
| kms | Lux Ecosystem v1.2 | Patent-protected |
| lamport | Lux Ecosystem v1.2 | Patent-protected |
| lattice | Lux Ecosystem v1.2 | Patent-protected |
| ledger | Apache-2.0 | Public |
| ledger-go | BSD-3-Clause | Public |
| lens | Apache-2.0 (with Lux copyright) | Public |
| license | BSD-3-Clause (canonical license-text repo) | Public |
| liquid | BSD-3-Clause | Public |
| log | BSD-3-Clause | Public |
| login | BSD-3-Clause | Public |
| logo | BSD-3-Clause | Public |
| lpm | BSD-3-Clause | Public |
| lux-ops | BSD-3-Clause | Public |
| markets | BSL 1.1 (inherited from Morpho Blue, time-limited) | Public, time-limited |
| math | BSD-3-Clause | Public |
| mdns | All Rights Reserved (Lux Industries Inc.) | Patent-protected |
| metric | BSD-3-Clause | Public |
| miner | Lux Research with Patent Reservation | Patent-protected |
| mlx | BSD-3-Clause | Public |
| mock | MIT | Public |
| monitoring | BSD-3-Clause | Public |
| mpc | Lux Ecosystem v1.2 | Patent-protected |
| net | BSD-3-Clause | Public |
| netrunner | BSD-3-Clause | Public |
| netrunner-sdk | BSD-3-Clause | Public |
| node | BSD-3-Clause | Public |
| onnx | Apache-2.0 | Public |
| oracle | BSD-3-Clause | Public |
| ordering | BSD-3-Clause | Public |
| p2p | BSD-3-Clause | Public |
| p3q-evm | Dual MIT / Apache-2.0 | Public |
| packages | BSD-3-Clause | Public |
| papers | BSD-3-Clause | Public |
| password | BSD-3-Clause | Public |
| plugins-core | BSD-3-Clause | Public |
| pq | MIT | Public |
| pq-profile-ids | Dual MIT / Apache-2.0 | Public |
| pqrns | Apache-2.0 | Public |
| pqsafe | Apache-2.0 | Public |
| precompile | Lux Ecosystem v1.2 | Patent-protected |
| price | BSD-3-Clause | Public |
| protocol | BSD-3-Clause | Public |
| pubsub | BSD-3-Clause | Public |
| pulsar | Apache-2.0 | Public |
| pulsar-mptc | Apache-2.0 | Public |
| qzmq | Apache-2.0 | Public |
| resource | BSD-3-Clause | Public |
| ringtail | Lux Ecosystem v1.2 | Patent-protected |
| rpc | BSD-3-Clause | Public |
| runtime | BSD-3-Clause | Public |
| safe | Lux Ecosystem v1.2 | Patent-protected |
| safe-frost | GPL-3.0 (inherited from Safe) | Public, copyleft |
| safe-ios | GPL-3.0 (inherited from Safe) | Public, copyleft |
| safe-wallet | GPL-3.0 (inherited from Safe) | Public, copyleft |
| sampler | Lux Research with Patent Reservation | Patent-protected |
| sdk | BSD-3-Clause | Public |
| securities | Apache-2.0 | Public |
| session | BSD-3-Clause | Public |
| snapshots | BSD-3-Clause | Public |
| stack | BSD-3-Clause | Public |
| staking | Lux Research with Patent Reservation | Patent-protected |
| standard | BSD-3-Clause | Public |
| state | Lux Genesis License v1.0 | Patent-protected (genesis-data carve-out) |
| sys | BSD-3-Clause | Public |
| teleport | BSD-3-Clause | Public |
| threshold | Lux Ecosystem v1.2 | Patent-protected |
| timer | BSD-3-Clause | Public |
| tls | BSD-3-Clause | Public |
| tokens | BSD-3-Clause | Public |
| trace | BSD-3-Clause | Public |
| tui | BSD-3-Clause | Public |
| uni-v2-subgraph | GPL-3.0 (inherited from Uniswap) | Public, copyleft |
| uni-v3-subgraph | GPL-3.0 (inherited from Uniswap) | Public, copyleft |
| uni-v4-subgraph | GPL-3.0 (inherited from Uniswap) | Public, copyleft |
| universe | BSD-3-Clause | Public |
| upgrade | BSD-3-Clause | Public |
| utils | BSD-3-Clause | Public |
| utxo | BSD-3-Clause | Public |
| validators | BSD-3-Clause | Public |
| version | BSD-3-Clause | Public |
| vm | Lux Research with Patent Reservation | Patent-protected |
| wallet | Lux Ecosystem v1.2 | Patent-protected |
| wallet-foundation | Lux Ecosystem v1.2 | Patent-protected |
| warp | Lux Ecosystem v1.2 | Patent-protected |
| web | BSD-3-Clause | Public |
| xwallet | MIT | Public |
| zap | BSD (Lux Industries Inc.) | Public |
| zapdb | Apache-2.0 | Public |
| zmq | BSD (vendored from go-zeromq) | Public |
| zwing | BSD-3-Clause | Public |

Repositories not listed above either have no `LICENSE` file (treat as
all-rights-reserved, contact `licensing@lux.network`) or are vendored
upstream forks where the inherited `LICENSE` is the binding artifact.

#### Vendored upstream forks (do not relicense)

`coreth`, `evm`, `evmgpu` carry **LGPL-3.0** because they originate from
`go-ethereum`. `explore` carries **GPL-3.0** from Blockscout. `safe-*`
carry GPL-3.0 from Safe (Gnosis). `uni-v*-subgraph` carry GPL-3.0 from
Uniswap. `czmq` carries MPL-2.0 from upstream. **None of these will be
relicensed** — the `LICENSE` is what governs use. The forward-looking
replacements live in `luxcpp/*` (e.g. `luxcpp/cevm` is Apache-2.0 and is
the going-forward EVM kernel; the LGPL `evm` repo will be retired as
`luxcpp/cevm` reaches feature parity).

### Extraction status (`lux-private/*`)

`lux-private/*` is the closed-source private GitHub organization that
holds the production performance moat. It is currently being bootstrapped.
The following are **slated for extraction** out of the public surface and
into `lux-private/*` once the org is provisioned and the responsible
engineers are added as members. Until extraction completes, the binding
license is whatever the public repo's `LICENSE` declares.

| Source | What moves | Target | Status |
|--------|------------|--------|--------|
| `luxfi/dex` | Production matching engine | `lux-private/dex-engine` | Pending org bootstrap |
| `luxfi/fpga` | FPGA bitstreams + RTL | `lux-private/fpga` | Pending org bootstrap |
| `luxcpp/cuda/*` | Already proprietary; will mirror to `lux-private/cuda` | `lux-private/cuda` | Pending org bootstrap |
| `luxcpp/lux-cuda`, `luxcpp/lux-metal`, `luxcpp/lux-webgpu` (no LICENSE) | GPU kernel sources | `lux-private/gpu-kernels` | Pending org bootstrap |

Treat anything in `lux-private/*` as commercial-only. There is no public
read access. There is no implied license. Use is governed exclusively by
a signed commercial agreement.

### Commercial licensing

| Tier / License | Contact |
|----------------|---------|
| Lux Ecosystem License v1.2 (Eco) | `licensing@lux.network` |
| Lux Research License with Patent Reservation | `oss@lux.network` |
| Lux Genesis License v1.0 | `licensing@lux.network` |
| Private moat (C++/CUDA/Metal/MLX/FPGA) | `licensing@lux.network` |

Every public repository carries a top-level `LICENSING.md` pointing back
to this document for context. The `LICENSE` file in each repo is the
binding artifact. This page is documentation, not a license.

## Core Projects

### Blockchain Infrastructure
| Project | Description |
|---------|-------------|
| [node](https://github.com/luxfi/node) | Lux blockchain node -- multi-consensus, post-quantum ready |
| [standard](https://github.com/luxfi/standard) | Reference implementation of Teleport protocol and quantum signatures |
| [teleport](https://github.com/luxfi/teleport) | Zero-knowledge MPC cross-chain bridge |
| [coreth](https://github.com/luxfi/coreth) | C-Chain EVM implementation (LGPL, vendored) |
| [evm](https://github.com/luxfi/evm) | Subnet EVM framework (LGPL, vendored) |

### Applications
| Project | Description |
|---------|-------------|
| [bridge](https://github.com/luxfi/bridge) | Teleport bridge UI + server |
| [exchange](https://github.com/luxfi/exchange) | AMM + DEX |
| [explore](https://github.com/luxfi/explore) | Block explorer (Blockscout fork, GPL) |
| [wallet](https://github.com/luxfi/wallet) | HD wallet implementation |

### SDKs and Tools
| Project | Description |
|---------|-------------|
| [js](https://github.com/luxfi/js) | Lux JavaScript SDK |
| [sdk](https://github.com/luxfi/sdk) | Multi-language SDK (Go, TypeScript, Python) |
| [cli](https://github.com/luxfi/cli) | Command-line interface |
| [netrunner](https://github.com/luxfi/netrunner) | Network testing and simulation tool |

## Ecosystem

| Organization | Focus | Link |
|---|---|---|
| **Lux Network** | Post-quantum blockchain, FHE, multi-consensus (this org) | [github.com/luxfi](https://github.com/luxfi) |
| **Lux C++** | High-performance C++ kernel and GPU acceleration | [github.com/luxcpp](https://github.com/luxcpp) |
| **Lux Private** | Closed-source production performance moat (private) | `github.com/lux-private` |
| **Lux FHE** | Fully homomorphic encryption research + SDK | [github.com/luxfhe](https://github.com/luxfhe) |
| **Hanzo AI** | AI infrastructure, LLM gateway, MCP tools | [github.com/hanzoai](https://github.com/hanzoai) |
| **Zen LM** | Frontier language models | [github.com/zenlm](https://github.com/zenlm) |
| **Zoo Labs** | Open AI research, DeSci, 501(c)(3) foundation | [github.com/zoo-labs](https://github.com/zoo-labs) |
| **Hanzo KMS** | Enterprise secret management | [github.com/hanzokms](https://github.com/hanzokms) |
| **Hanzo ID** | Identity, OAuth2/OIDC, WebAuthn | [github.com/hanzoid](https://github.com/hanzoid) |

### Links
- [Papers](https://github.com/luxfi/papers) -- research papers (LaTeX)
- [Security](https://github.com/luxfi/node/blob/main/SECURITY.md) -- cryptographic audit trail
- [License text repo](https://github.com/luxfi/license) -- canonical license text

## Resources

- [lux.network](https://lux.network) -- Website
- [docs.lux.network](https://docs.lux.network) -- Documentation
- [explorer.lux.network](https://explorer.lux.network) -- Block explorer

*Built by the Lux team in collaboration with [Hanzo AI](https://hanzo.ai)*
