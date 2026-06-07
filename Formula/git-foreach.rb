class GitForeach < Formula
  desc "Run a command across many local git repositories from a mouse-driven TUI"
  homepage "https://github.com/m5d215/git-foreach"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m5d215/git-foreach/releases/download/v0.3.0/git-foreach-macos-arm64.tar.gz"
      sha256 "3d934073b3ed2a31ef5ce3acfdc9d46d784ebad5e720ef4b28269f9186d91cad"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/git-foreach/releases/download/v0.3.0/git-foreach-linux-x86_64.tar.gz"
      sha256 "5a93a4df5f814346030a4fdf141980e1132bfb58cb85dbbfa0eaa3c3bf4ec437"
    end
  end

  def install
    bin.install "git-foreach"
    pkgshare.install "LICENSE-MIT"
    doc.install "README.md"
  end

  test do
    assert_match "git-foreach ", shell_output("#{bin}/git-foreach --version")
  end
end
