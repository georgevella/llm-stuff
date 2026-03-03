# Semantic Release Monorepo Template

Starter scaffold for independent multi-publishable releases from one repository.

## Included
- Shared branch policy: `.releaserc.yaml`
- Publishable configs: `.releaserc.app.json`, `.releaserc.helm.json`
- GitHub Actions workflow: `.github/workflows/release.yml`
- Release scripts: `scripts/*.sh`
- Ops docs: `docs/semantic-release.md`, `docs/release-ops-checklist.md`

## Defaults
- Full branch policy (`master`, `next`, `next-major`, `beta`, `alpha`, maintenance)
- Distinct tags (`v${version}` and `helm-v${version}`)
- `actions/checkout@v4`
- `fetch-depth: 0` for release jobs
- Script argument mode: `version_only`

## Quick Start
1. Copy this template into your target repository root.
2. Adjust path filters in `.github/workflows/release.yml`.
3. Update environment variable mappings in release jobs.
4. Adjust publish scripts for your registries/package repos.
5. Run dry-runs before enabling live releases.

See `apply-template.md` for a full checklist.
