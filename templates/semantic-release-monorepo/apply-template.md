# Apply Template

## 1) Copy Files
Copy all files from this template into the new repository root.

## 2) Configure Publishables
- Keep or rename `.releaserc.app.json` and `.releaserc.helm.json`.
- Ensure each publishable has a unique `tagFormat`.

## 3) Update Workflow Path Filters
In `.github/workflows/release.yml`, update `dorny/paths-filter` rules:
- app filter paths
- helm filter paths

## 4) Wire Credentials
Set repo/org secrets and map them in workflow `env`:
- `GH_TOKEN` (use `${{ secrets.GITHUB_TOKEN }}`)
- app target creds (`REGISTRY`, `REPOSITORY`, cloud auth)
- helm target creds (`HELM_USERNAME`, `HELM_PASSWORD`, `HELM_REPOSITORY`)

## 5) Align Scripts With Your Targets
- `scripts/publish.sh`: container/image/artifact publish logic
- `scripts/helm-publish.sh`: chart upload target

## 6) Validate Branch Policy
Ensure release workflow trigger branches intentionally match your strategy.

## 7) Dry Run
```bash
npx semantic-release --dry-run --no-ci --extends ./.releaserc.yaml --extends ./.releaserc.app.json
npx semantic-release --dry-run --no-ci --extends ./.releaserc.yaml --extends ./.releaserc.helm.json
```

## 8) Go Live
Push a conventional-commit change to a release branch and confirm:
- tag created in correct namespace
- GitHub release created
- publish target updated
