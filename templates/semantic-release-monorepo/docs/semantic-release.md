# Semantic Release Setup

## Model
This repository uses independent semantic-release streams:
- app release stream (`v${version}`)
- helm release stream (`helm-v${version}`)

Shared branch/channel policy is in `.releaserc.yaml`.

## Commands
App release:
```bash
npx semantic-release --extends ./.releaserc.yaml --extends ./.releaserc.app.json
```

Helm release:
```bash
npx semantic-release --extends ./.releaserc.yaml --extends ./.releaserc.helm.json
```

Dry-run:
```bash
npx semantic-release --dry-run --no-ci --extends ./.releaserc.yaml --extends ./.releaserc.app.json
npx semantic-release --dry-run --no-ci --extends ./.releaserc.yaml --extends ./.releaserc.helm.json
```

## Required Environment Variables
App:
- `GH_TOKEN`
- `REGISTRY`
- `REPOSITORY`
- `RELEASE_DOCKERFILE`

Helm:
- `GH_TOKEN`
- `HELM_USERNAME`
- `HELM_PASSWORD`
- `HELM_REPOSITORY`
- `HELM_CHART_NAME` (optional, default `chart`)
- `HELM_CHART_DIRECTORY` (optional, default `./helm/chart`)

## Guardrails
- Keep tag namespaces unique per publishable.
- Keep workflow trigger branches aligned with branch policy.
- Use `fetch-depth: 0` in release jobs.
- Keep script argument contract as `<version>` unless intentionally changed.
