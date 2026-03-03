# Semantic Release Skill Session Notes (2026-03-03)

## Goal
Capture reusable knowledge for teaching AI agents how to implement and audit `semantic-release` in monorepos with multiple publishables.

## Repositories Reviewed
- `/home/georgevella/src/rivertech/tools/service-essentials-operator`
- `/home/georgevella/src/rivertech/tools/opensearch-serverless-proxy`

## Reusable Pattern Identified
- Shared branch/channel policy in `.releaserc.yaml`.
- Per-publishable semantic-release configs.
- Distinct tag namespaces per publishable (`v${version}` vs `helm-v${version}`).
- Plugin chain: commit analyzer, release notes, exec, changelog, github.
- CI orchestration can gate release jobs by changed paths.

## Key Inconsistencies (Now Skill Parameters)
- App publish script argument contract differs across repos (`version_only` vs `target_and_version`).
- Workflow maturity differs (missing committed workflow in one repo).
- Workflow trigger branches may not cover full semantic-release branch policy.
- Checkout depth/version strategy differs (`fetch-depth: 2` vs recommended `0`, mixed checkout action majors).
- Documentation can drift from actual config filenames (`.yaml` docs vs `.json` files).
- Publish implementation completeness differs (placeholder helm scripts vs working helm publish flow).

## Artifacts Generated In This Workspace
- `skills/semantic-release-monorepo/skill.md`
- `skills/semantic-release-monorepo/memory.yaml`
- `skills/semantic-release-monorepo/docs.md`
- `skills/semantic-release-monorepo/deferred-actions.md`
- `skills/README.md`

## Deferred Action To Resume Later
- Generate repo bootstrap templates from the semantic-release skill memory/defaults.
- Resume prompt: "Generate the repo bootstrap template set from semantic-release-monorepo."

## Structural Decision
- Skills should be folder-based for scalability.
- Current convention:
  - `skills/<skill-name>/skill.md`
  - `skills/<skill-name>/memory.yaml`
  - `skills/<skill-name>/docs.md`
  - `skills/<skill-name>/deferred-actions.md`
