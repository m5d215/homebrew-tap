class ClaudeHistory < Formula
  desc "Search and browse Claude Code conversation logs"
  homepage "https://github.com/m5d215/claude-history"
  url "https://github.com/m5d215/claude-history.git",
      tag: "v0.1.1"
  license "MIT"
  head "https://github.com/m5d215/claude-history.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: ".")
  end

  test do
    assert_match "Search Claude Code", shell_output("#{bin}/claude-history --help")
  end
end
