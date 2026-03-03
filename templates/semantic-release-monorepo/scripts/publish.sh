#!/usr/bin/env bash

set -euo pipefail
source ./scripts/version.sh "$1"

mkdir -p ./artifacts/app

if [ -d ./output ]; then
  tar czf ./artifacts/app/release-${VERSION}.tar.gz ./output
fi

if [ -n "${REGISTRY:-}" ] && [ -n "${REPOSITORY:-}" ] && [ -n "${RELEASE_DOCKERFILE:-}" ]; then
  docker buildx build . \
    --platform linux/amd64,linux/arm64 \
    -f "${RELEASE_DOCKERFILE}" \
    -t "${REGISTRY}/${REPOSITORY}:${VERSION}" \
    --push
else
  echo "Container publish skipped (set REGISTRY, REPOSITORY, and RELEASE_DOCKERFILE to enable)"
fi
