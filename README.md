# Homebrew OpenCode Agent Hub

Homebrew formula for [opencode-agent-hub](https://github.com/xnoto/opencode-agent-hub).

## Installation

```bash
brew tap xnoto/opencode-agent-hub
brew install opencode-agent-hub
```

Or in one command:

```bash
brew install xnoto/opencode-agent-hub/opencode-agent-hub
```

## Usage

### Start as a service

```bash
brew services start opencode-agent-hub
```

### Run manually

```bash
agent-hub-daemon    # Start the daemon
agent-hub-watch     # Monitor dashboard
```

### Stop service

```bash
brew services stop opencode-agent-hub
```

## Updating the Formula

Formula updates are owned by the source repository's `.github/workflows/update-homebrew.yml` workflow. After publishing an `opencode-agent-hub` GitHub release:

1. Dispatch the `Update Homebrew Tap` workflow in `xnoto/opencode-agent-hub`.
2. Review its automation-generated pull request in this repository.
3. Verify the release URL, SHA256, upstream license, dependencies, and formula resources.
4. Require the Homebrew Audit check to pass before merging.

Direct formula edits are a recovery path when the automation itself needs repair. Installing or upgrading the formula locally changes the machine and should be done intentionally.

## License

The tap repository is MIT licensed; see [LICENSE](LICENSE). The packaged `opencode-agent-hub` software is AGPL-3.0-only, and the formula records the upstream license.
