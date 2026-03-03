#!/usr/bin/env bash

set -euo pipefail
source ./scripts/version.sh "$1"

CHART_NAME="${HELM_CHART_NAME:-chart}"
CHART_PATH="./dist/packages/${CHART_NAME}-${VERSION}.tgz"

if [ ! -f "$CHART_PATH" ]; then
  echo "Chart archive not found: $CHART_PATH"
  exit 1
fi

if [ -z "${HELM_USERNAME:-}" ] || [ -z "${HELM_PASSWORD:-}" ] || [ -z "${HELM_REPOSITORY:-}" ]; then
  echo "HELM_USERNAME, HELM_PASSWORD, and HELM_REPOSITORY must be set"
  exit 1
fi

curl -u "${HELM_USERNAME}:${HELM_PASSWORD}" "${HELM_REPOSITORY}" --upload-file "$CHART_PATH"
cp "$CHART_PATH" ./artifacts/helm/
