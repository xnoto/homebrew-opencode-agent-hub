class OpencodeAgentHub < Formula
  include Language::Python::Virtualenv

  desc "Multi-agent coordination daemon and tools for OpenCode"
  homepage "https://github.com/xnoto/opencode-agent-hub"
  url "https://github.com/xnoto/opencode-agent-hub/archive/refs/tags/v1.6.2.tar.gz"
  sha256 "3391c253880468d65519b374b19965c53331739ece7a15716b263c66336a92ef"
  license "AGPL-3.0-only"

  deprecate! date: "2026-08-30", because: :repo_archived

  depends_on "python@3.11"
  depends_on "rust" => :build

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

  resource "prometheus-client" do
    url "https://files.pythonhosted.org/packages/1b/fb/d9aa83ffe43ce1f19e557c0971d04b90561b0cfd50762aafb01968285553/prometheus_client-0.25.0.tar.gz"
    sha256 "5e373b75c31afb3c86f1a52fa1ad470c9aace18082d39ec0d2f918d11cc9ba28"
  end

  resource "pydantic" do
    url "https://files.pythonhosted.org/packages/09/e5/06d23afac9973109d1e3c8ad38e1547a12e860610e327c05ee686827dc37/pydantic-2.13.2.tar.gz"
    sha256 "b418196607e61081c3226dcd4f0672f2a194828abb9109e9cfb84026564df2d1"
  end

  resource "pydantic-core" do
    url "https://files.pythonhosted.org/packages/43/bb/4742f05b739b2478459bb16fa8470549518c802e06ddcf3f106c5081315e/pydantic_core-2.46.2.tar.gz"
    sha256 "37bb079f9ee3f1a519392b73fda2a96379b31f2013c6b467fe693e7f2987f596"
  end

  resource "annotated-types" do
    url "https://files.pythonhosted.org/packages/ee/67/531ea369ba64dcff5ec9c3402f9f51bf748cec26dde048a2f973a4eea7f5/annotated_types-0.7.0.tar.gz"
    sha256 "aff07c09a53a08bc8cfccb9c85b05f1aa9a2a6f23728d790723543408344ce89"
  end

  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/72/94/1a15dd82efb362ac84269196e94cf00f187f7ed21c242792a923cdb1c61f/typing_extensions-4.15.0.tar.gz"
    sha256 "0cea48d173cc12fa28ecabc3b837ea3cf6f38c6d1136f85cbaaf598984861466"
  end

  resource "typing-inspection" do
    url "https://files.pythonhosted.org/packages/55/e3/70399cb7dd41c10ac53367ae42139cf4b1ca5f36bb3dc6c9d33acdb43655/typing_inspection-0.4.2.tar.gz"
    sha256 "ba561c48a67c5958007083d386c3295464928b01faa735ab8547c5692e87f464"
  end

  def install
    virtualenv_install_with_resources
    pkgshare.install "contrib/launchd/com.xnoto.agent-hub-daemon.plist"
    # Install coordinator templates for cross-platform discovery
    (pkgshare/"coordinator").install "contrib/coordinator/opencode.json"
    (pkgshare/"coordinator").install "contrib/coordinator/AGENTS.md"
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
