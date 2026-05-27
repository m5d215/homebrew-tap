class ClaudeHistory < Formula
  desc "Search and browse Claude Code conversation logs"
  homepage "https://github.com/m5d215/claude-history"
  version "0.1.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m5d215/claude-history/releases/download/v0.1.3/claude-history-macos-arm64.tar.gz"
      sha256 "7aac2ffb55e93b102924ba54da95a519e16b9d3a57c6183d05308ac98343ebb8"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/claude-history/releases/download/v0.1.3/claude-history-linux-x86_64.tar.gz"
      sha256 "3a036c729aeef7b9513c07a48fe26dfdb8b5ede025023723a27ab4d9eb3189ea"
    end
  end

  def install
    bin.install "claude-history"
  end

  test do
    assert_match "Search Claude Code", shell_output("#{bin}/claude-history --help")
  end
end
