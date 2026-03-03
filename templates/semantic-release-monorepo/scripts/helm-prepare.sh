#!/usr/bin/env bash

set -euo pipefail
source ./scripts/version.sh "$1"

CHART_DIRECTORY="${HELM_CHART_DIRECTORY:-./helm/chart}"

mkdir -p ./dist/packages
mkdir -p ./artifacts/helm

helm dep update "$CHART_DIRECTORY"
helm lint "$CHART_DIRECTORY"
helm package "$CHART_DIRECTORY" -d ./dist/packages --version "$VERSION"
