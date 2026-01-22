class OpencodeAgentHub < Formula
  include Language::Python::Virtualenv

  desc "Multi-agent coordination daemon and tools for OpenCode"
  homepage "https://github.com/xnoto/opencode-agent-hub"
  url "https://files.pythonhosted.org/packages/source/o/opencode-agent-hub/opencode_agent_hub-0.1.0.tar.gz"
  sha256 "UPDATE_WITH_ACTUAL_SHA256_AFTER_PYPI_PUBLISH"
  license "MIT"

  depends_on "python@3.11"

  resource "requests" do
    url "https://files.pythonhosted.org/packages/63/70/2bf7780ad2d390a8d301ad0b550f1581eadbd9a20f896uj51cfd3cab721/requests-2.32.3.tar.gz"
    sha256 "55365417734eb18255590a9ff9eb97e9e1da868d4ccd6402399eaf68af20a760"
  end

  resource "watchdog" do
    url "https://files.pythonhosted.org/packages/a2/48/a86139aaeab2db0a2482676f64798d8ac4d2dbb1e698b6043da1d50ca2da/watchdog-6.0.0.tar.gz"
    sha256 "9ddf7c82fda3ae8e24decda1338ede66e1c99883db93711d8fb941eaa2d8c282"
  end

  # Add other transitive dependencies as needed (urllib3, certifi, etc.)
  # Run `poet opencode-agent-hub` to generate complete resource stanzas

  def install
    virtualenv_install_with_resources
  end

  def caveats
    <<~EOS
      To start the daemon automatically at login:
        cp #{opt_prefix}/share/launchd/com.xnoto.agent-hub-daemon.plist ~/Library/LaunchAgents/
        launchctl load ~/Library/LaunchAgents/com.xnoto.agent-hub-daemon.plist

      Or run manually:
        agent-hub-daemon

      Monitor with:
        agent-hub-watch
    EOS
  end

  service do
    run [opt_bin/"agent-hub-daemon"]
    keep_alive true
    log_path var/"log/agent-hub-daemon.log"
    error_log_path var/"log/agent-hub-daemon.log"
  end

  test do
    assert_match "opencode_agent_hub", shell_output("#{bin}/agent-hub-daemon --help 2>&1", 1)
  end
end
