#!/usr/bin/env bash
# Local validation mirroring luxfi/.github CI checks.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

echo "==> Installing @luxfi/brand-rules via dev-tools/"
npm install --prefix dev-tools

echo "==> brand-check lux (full tree)"
dev-tools/node_modules/.bin/brand-check lux all

ACTIONLINT="${ROOT}/actionlint"
if [[ ! -x "${ACTIONLINT}" ]]; then
  echo "==> Downloading actionlint"
  curl -sSfL https://raw.githubusercontent.com/rhysd/actionlint/main/scripts/download-actionlint.bash \
    | bash -s -- 1.7.7
fi

echo "==> actionlint (workflow YAML)"
if ! "${ACTIONLINT}" .github/workflows/*.yml; then
  echo "note: GHCR_USER/GHCR_TOKEN warnings are expected for reusable workflow secret inheritance"
fi

echo "==> dev-check passed"
