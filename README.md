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

After a new version is published to PyPI:

1. Get the new SHA256:
   ```bash
   VERSION=X.Y.Z
   curl -sL "https://files.pythonhosted.org/packages/source/o/opencode-agent-hub/opencode_agent_hub-${VERSION}.tar.gz" | shasum -a 256
   ```

2. Update `Formula/opencode-agent-hub.rb`:
   - Update version in URL
   - Update SHA256

3. Test locally:
   ```bash
   brew install --build-from-source ./Formula/opencode-agent-hub.rb
   ```

4. Commit and push

## License

MIT - See [LICENSE](LICENSE) for details.
