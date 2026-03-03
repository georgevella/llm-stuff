# Semantic Release Skill Notes

## Comparison Summary

Compared repositories:
- `/home/georgevella/src/rivertech/tools/service-essentials-operator`
- `/home/georgevella/src/rivertech/tools/opensearch-serverless-proxy`

## Common Model (Reusable)
- Shared branch policy in `.releaserc.yaml` with stable, prerelease, and maintenance branches.
- Independent publishables use separate semantic-release config files.
- Distinct tag namespaces prevent stream collisions:
  - app: `v${version}`
  - helm: `helm-v${version}`
- Plugin chain is consistent:
  - commit analyzer
  - release notes generator
  - exec
  - changelog
  - github release

## Inconsistencies Found (Turned Into Skill Parameters)

1. Script argument contract
- `service-essentials-operator` app script expects `<target> <version>`.
- `opensearch-serverless-proxy` scripts expect `<version>` only.
- Parameterized as `app_publish_argument_mode`.

2. Workflow availability and maturity
- `service-essentials-operator` has no committed `.github/workflows` release orchestration.
- `opensearch-serverless-proxy` has path-filtered release jobs committed.
- Parameterized as `workflow_file`, `path_filters`, and `setup_tools_strategy`.

3. Trigger-branch vs release-policy mismatch
- `opensearch-serverless-proxy` workflow triggers only on `master` and `alpha`.
- Shared semantic-release policy includes `next`, `next-major`, `beta`, maintenance branches.
- Parameterized as `workflow_release_branches`.

4. Checkout depth and version consistency
- `opensearch-serverless-proxy` uses shallow checkout (`fetch-depth: 2`) and mixed checkout action versions (`v4`, `v6`).
- Parameterized as `checkout_fetch_depth_mode` and `actions_checkout_version_mode`.

5. Docs/config filename drift
- `opensearch-serverless-proxy/docs/semantic-release-setup.md` references `.yaml` per-publishable config names while tracked files are `.json`.
- Parameterized as `docs_config_filename_style` with validation.

6. Implementation completeness
- `service-essentials-operator` helm scripts are placeholders.
- `opensearch-serverless-proxy` helm scripts are implemented (lint, package, upload).
- Parameterized as publishable readiness checks (`prepare_cmd`, `publish_cmd`, credential set).

## Skill Guardrails
- Require unique tag formats across publishables.
- Require script command arity to match semantic-release commands.
- Require non-placeholder publish scripts for active publishables.
- Require CI checkout depth 0 for release jobs unless explicitly overridden.
- Require workflow triggers to intentionally match or intentionally subset branch policy.
- Require docs to match actual config filenames and command examples.

## Recommended Baseline For New Repos
- Keep shared policy in `.releaserc.yaml`.
- Keep per-publishable configs in `.releaserc.<id>.json`.
- Use `semantic-release --extends ./.releaserc.yaml --extends ./.releaserc.<id>.json`.
- Use workflow `detect-changes` + per-publishable jobs.
- Use `actions/checkout@v4` with `fetch-depth: 0` in release jobs.
- Add dry-run checks per publishable in PR pipelines.

## Adoption Checklist
- [ ] Define publishables and unique tag formats.
- [ ] Define script argument contract and enforce it.
- [ ] Add per-publishable path filters.
- [ ] Add required credentials map per publishable.
- [ ] Align workflow trigger branches with semantic-release policy.
- [ ] Add dry-run commands for each publishable.
- [ ] Verify docs reference actual file names and commands.
