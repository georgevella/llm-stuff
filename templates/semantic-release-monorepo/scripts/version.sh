#!/usr/bin/env bash

set -euo pipefail

VERSION="${1:-}"

if [ -z "$VERSION" ]; then
  echo "Version not supplied. Use: $0 <version>"
  exit 1
fi

export VERSION
