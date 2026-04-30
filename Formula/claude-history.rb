class ClaudeHistory < Formula
  desc "Search and browse Claude Code conversation logs"
  homepage "https://github.com/m5d215/claude-history"
  version "0.1.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m5d215/claude-history/releases/download/v0.1.2/claude-history-macos-arm64.tar.gz"
      sha256 "5517f0768b071ba1ad51e0093c03a2bf9544932b44cb6bec42f46c91a10bd7f9"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/claude-history/releases/download/v0.1.2/claude-history-linux-x86_64.tar.gz"
      sha256 "ff152bb172e94cdc41f764e4571efe928a07c638c4385262d7a05aefcdaae06c"
    end
  end

  def install
    bin.install "claude-history"
  end

  test do
    assert_match "Search Claude Code", shell_output("#{bin}/claude-history --help")
  end
end
