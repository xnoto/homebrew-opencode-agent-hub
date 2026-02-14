class OpencodeAgentHub < Formula
  include Language::Python::Virtualenv

  desc "Multi-agent coordination daemon and tools for OpenCode"
  homepage "https://github.com/xnoto/opencode-agent-hub"
  url "https://github.com/xnoto/opencode-agent-hub/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "bffb1b94e802102e1c6f87ececd423c1e04e21369977136b1e170f5fa64b4f3b"
  license "MIT"

  depends_on "python@3.11"

  resource "requests" do
    url "https://files.pythonhosted.org/packages/source/r/requests/requests-2.32.3.tar.gz"
    sha256 "55365417734eb18255590a9ff9eb97e9e1da868d4ccd6402399eaf68af20a760"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/source/c/certifi/certifi-2024.12.14.tar.gz"
    sha256 "b650d30f370c2b724812bee08008be0c4163b163ddaec3f2546c1caf65f191db"
  end

  resource "charset" do
    url "https://files.pythonhosted.org/packages/source/c/charset-normalizer/charset_normalizer-3.4.0.tar.gz"
    sha256 "223217c3d4f82c3ac5e29032b3f1c2eb0fb591b72161f86d93f5719079dae93e"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/source/i/idna/idna-3.10.tar.gz"
    sha256 "12f65c9b470abda6dc35cf8e63cc574b1c52b11df2c86030af0ac09b01b13ea9"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/source/u/urllib3/urllib3-2.2.3.tar.gz"
    sha256 "e7d814a81dad81e6caf2ec9fdedb284ecc9c73076b62654547cc64ccdcae26e9"
  end

  resource "watchdog" do
    url "https://files.pythonhosted.org/packages/source/w/watchdog/watchdog-6.0.0.tar.gz"
    sha256 "9ddf7c82fda3ae8e24decda1338ede66e1c99883db93711d8fb941eaa2d8c282"
  end

  # Add other transitive dependencies as needed (urllib3, certifi, etc.)
  # Run `poet opencode-agent-hub` to generate complete resource stanzas

  def install
    virtualenv_install_with_resources
    pkgshare.install "contrib/launchd/com.xnoto.agent-hub-daemon.plist"
  end

  def caveats
    <<~EOS
      To start the daemon automatically at login:
        cp #{pkgshare}/com.xnoto.agent-hub-daemon.plist ~/Library/LaunchAgents/
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
