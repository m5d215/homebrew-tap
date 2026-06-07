class GitForeach < Formula
  desc "Run a command across many local git repositories from a mouse-driven TUI"
  homepage "https://github.com/m5d215/git-foreach"
  version "0.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m5d215/git-foreach/releases/download/v0.4.0/git-foreach-macos-arm64.tar.gz"
      sha256 "355766b699c4ed5122fb7cfd0b2d3fe21c9b6bd93d41cb402d9852f7f7dbd3de"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/git-foreach/releases/download/v0.4.0/git-foreach-linux-x86_64.tar.gz"
      sha256 "de0b22a8f3f506e4d2148e8580738584b8dec1ec6b4a05c4c166cb00ba621633"
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
