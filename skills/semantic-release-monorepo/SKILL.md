---
name: semantic-release-monorepo
description: Standardize and automate semantic-release for monorepos with multiple publishables and independent version streams.
---

# Skill: semantic-release-monorepo

## Purpose
Standardize and automate `semantic-release` for monorepos with multiple publishables (for example app + helm), while preserving independent version streams.

## Scope
This skill supports:
- independent tag namespaces per publishable
- prerelease channels (`alpha`, `beta`) and stable channel (`master`)
- publish delegation through shell scripts (`@semantic-release/exec`)
- GitHub Actions orchestration (path-based release gating)

## Inputs
Use these parameters (defaults in memory file):
- `base_config_file`: shared branch/channel config
- `publishables[]`:
  - `id`
  - `config_file`
  - `tag_format`
  - `prepare_cmd`
  - `publish_cmd`
  - `success_cmd`
  - `artifact_glob`
  - `changelog_file`
- `branch_policy`: release/prerelease branches
- `workflow_file`: CI workflow path
- `path_filters`: changed-path rules for each publishable
- `ci_node_version`
- `checkout_fetch_depth`
- `requires_full_history_for_release`
- `credentials`: env var names by publishable
- `pre_release_mode`: `enabled`/`disabled`

## Procedure
1. Read shared and per-publishable semantic-release configs.
2. Validate that each publishable has a unique tag format.
3. Validate `prepareCmd`/`publishCmd` argument contracts against scripts.
4. Validate plugin chain and output paths for changelog/assets.
5. Validate workflow orchestration:
   - changed-path detection
   - job gating per publishable
   - required setup steps and secrets
   - release command wiring
6. Run dry-run command templates for each publishable.
7. Produce remediation patches and docs for any mismatches.

## Hard-Fail Conditions
- duplicate tag namespaces across publishables
- script arity mismatch with semantic-release command
- placeholder publish scripts connected to active release config
- workflow missing release branch triggers for intended channels
- semantic-release docs/config naming mismatch that can mislead operators

## Checks
- Branch policy present in shared config
- Conventional commits analyzer and release notes generator configured
- `@semantic-release/exec` present when external publish logic is required
- changelog path and GitHub assets path are valid and intentional
- release job has required credentials for its target registry/repository

## Command Templates
```bash
npx semantic-release --dry-run --no-ci --extends ./.releaserc.yaml --extends ./.releaserc.app.json
npx semantic-release --dry-run --no-ci --extends ./.releaserc.yaml --extends ./.releaserc.helm.json
```

## Output Contract
Skill execution should output:
- `comparison matrix` (repo A vs repo B)
- `parameterized config model` (what is fixed vs variable)
- `risk register` with severity and fix action
- `adoption checklist` for new repositories
