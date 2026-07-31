# AGENTS.md

Guidance for maintaining the Homebrew distribution of `opencode-agent-hub`.

## Ownership and automation

This repository owns the tap and formula, not the Agent Hub source package. Source releases and release metadata are authoritative in `xnoto/opencode-agent-hub`.

Normal formula updates are produced by `.github/workflows/update-homebrew.yml` in the source repository. That workflow resolves the latest GitHub release, computes the archive SHA256, updates formula metadata, and opens an automation-generated pull request here. Prefer fixing or running that automation over hand-maintaining a parallel release path.

Before changing `Formula/opencode-agent-hub.rb`, verify:

- published release tag and source archive URL
- source archive SHA256
- upstream software license
- Python version and direct dependencies
- every Homebrew resource URL and SHA256
- whether the automation-generated update is already open

The tap repository itself is MIT licensed; the packaged Agent Hub software is AGPL-3.0-only. Keep the formula license aligned with the packaged release.

## Safety boundaries

Safe source validation:

```bash
pre-commit run --all-files
ruby -c Formula/opencode-agent-hub.rb
```

On macOS, `.github/workflows/ci.yml` creates a local tap symlink, trusts that tap, and runs `brew audit --strict`. Those steps modify Homebrew state; inspect the workflow and obtain confirmation before reproducing them locally. Do not audit an installed or stale tap as a substitute for the working checkout.

Do not run `brew install`, `brew upgrade`, `brew services`, publish releases, dispatch the source update workflow, or merge formula PRs without explicit confirmation. These actions modify the machine or external distribution state.

## Contribution workflow

`main` is protected. Use a feature branch and Conventional Commits, run the narrowest relevant checks, and merge through a pull request with a passing Homebrew Audit check. Formula changes and unrelated project-scoped `opencode.json` changes should remain separate when practical.
