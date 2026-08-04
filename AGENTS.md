# AGENTS.md

Guidance for cloud agents and developers working in `luxfi/.github`.

## What this repository is

This is **not** an application monorepo. It holds:

- Reusable GitHub Actions workflows (`brand-sovereignty.yml`, `docker.yml`)
- GitHub organization profile documentation (`profile/`)
- Org README assets (`.github/hero.svg`)

There is no long-running service, database, or Docker image built from this tree. Local development validates the **CI tooling chain** (brand sovereignty checks and workflow YAML).

## Prerequisites

The VM image already includes Node.js 22 and npm. Global `npm install -g` fails without root; use the committed `dev-tools/` package instead.

Optional: `curl` and `bash` for downloading `actionlint` (handled by `scripts/dev-check.sh`).

## Quick start

```bash
# One-shot local CI mirror
./scripts/dev-check.sh

# Or run pieces manually
npm install --prefix dev-tools
dev-tools/node_modules/.bin/brand-check lux all
```

### brand-check orgs

`brand-check` accepts: `lux`, `hanzo`, `zoo`, `pars`, `liquidity`.

```bash
dev-tools/node_modules/.bin/brand-check lux all          # full tree
dev-tools/node_modules/.bin/brand-check lux origin/main  # PR-style diff
```

### Workflow linting

```bash
curl -sSfL https://raw.githubusercontent.com/rhysd/actionlint/main/scripts/download-actionlint.bash | bash -s -- 1.7.7
./actionlint .github/workflows/*.yml
```

`actionlint` may warn that `secrets.GHCR_USER` / `secrets.GHCR_TOKEN` are undefined on `docker.yml`. That is expected: those secrets are declared for cross-org `workflow_call` callers and passed via `secrets: inherit` at runtime.

## What you cannot run locally

- **Docker build workflow**: `docker.yml` targets self-hosted ARC runners (`evo`, `spark`) and pushes to GHCR. It is not designed to run on a generic cloud VM without org secrets and runner labels.
- **Brand sovereignty in GitHub Actions**: the reusable workflow runs on `ubuntu-24.04` with a global npm install; locally we use the same `@luxfi/brand-rules` package from npm.

## Cursor Cloud specific instructions

- **Update script scope**: `npm install --prefix dev-tools` refreshes `@luxfi/brand-rules`. No application servers to start.
- **Hello-world validation**: `./scripts/dev-check.sh` — confirms brand rules pass and workflows parse.
- **No docker compose / no go build**: nothing in this repo compiles Go or runs containers for its own CI.
- **Branch naming**: cloud agents use `cursor/<descriptive-name>-e73e`.
- **Primary workflow consumers**: `luxfi/*`, `hanzoai/*`, and partner orgs reference these reusable workflows from their own repos.
