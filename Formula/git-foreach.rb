class GitForeach < Formula
  desc "Run a command across many local git repositories from a mouse-driven TUI"
  homepage "https://github.com/m5d215/git-foreach"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m5d215/git-foreach/releases/download/v0.2.0/git-foreach-macos-arm64.tar.gz"
      sha256 "c73ef73eeb7a0863ccd52cf99e41a8c56bd0b84d165ac056a893251faa7f76bf"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/git-foreach/releases/download/v0.2.0/git-foreach-linux-x86_64.tar.gz"
      sha256 "6d5c3e2352e743450c07b3e1337428c064dc6d9918adb71e483bb8f97d8155ba"
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
