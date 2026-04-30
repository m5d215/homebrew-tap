class AgentSalonSlack < Formula
  desc "Bridge between Slack and Claude Code sessions via agent-salon"
  homepage "https://github.com/m5d215/agent-salon-slack"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m5d215/agent-salon-slack/releases/download/v0.1.0/agent-salon-slack-macos-arm64.tar.gz"
      sha256 "9940008f20f076c32bd28e3fcea47ee21a18d143a555200dc4c62ec5e45344a0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/agent-salon-slack/releases/download/v0.1.0/agent-salon-slack-linux-x86_64.tar.gz"
      sha256 "5b7b37aee1d130f983a2188a441502fc14e7d5bb73e4df255ca278e0f1ab14bc"
    end
  end

  def install
    bin.install "agent-salon-slack"
    pkgshare.install "LICENSE", "THIRD-PARTY-LICENSES.md", "manifest.yml", ".env.example"
    doc.install "README.md"
  end

  test do
    output = shell_output("#{bin}/agent-salon-slack 2>&1", 1)
    assert_match "startup.fatal", output
  end
end
