class GitForeach < Formula
  desc "Run a command across many local git repositories from a mouse-driven TUI"
  homepage "https://github.com/m5d215/git-foreach"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m5d215/git-foreach/releases/download/v0.1.0/git-foreach-macos-arm64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/git-foreach/releases/download/v0.1.0/git-foreach-linux-x86_64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
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
