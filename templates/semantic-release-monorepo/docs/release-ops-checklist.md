# Release Ops Checklist

- [ ] Conventional commits enforced.
- [ ] `.releaserc.yaml` branch policy reviewed.
- [ ] Each publishable has a unique `tagFormat`.
- [ ] Workflow path filters map to real source/chart paths.
- [ ] Workflow secrets are configured.
- [ ] Release scripts are executable and non-placeholder.
- [ ] Dry-run passes for all publishables.
- [ ] First live release verified in GitHub Releases and publish targets.
