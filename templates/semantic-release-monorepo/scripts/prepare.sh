#!/usr/bin/env bash

set -euo pipefail
source ./scripts/version.sh "$1"

mkdir -p ./output
mkdir -p ./artifacts/app

if [ -n "${APP_BUILD_CMD:-}" ]; then
  sh -c "$APP_BUILD_CMD"
else
  echo "No APP_BUILD_CMD set; skipping build step"
fi
