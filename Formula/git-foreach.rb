class GitForeach < Formula
  desc "Run a command across many local git repositories from a mouse-driven TUI"
  homepage "https://github.com/m5d215/git-foreach"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m5d215/git-foreach/releases/download/v0.1.0/git-foreach-macos-arm64.tar.gz"
      sha256 "2d686c2fc6fa1c8f4a6b9a0efe3e4bc5016e164afeb4a92d4a07c764eda094e0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/git-foreach/releases/download/v0.1.0/git-foreach-linux-x86_64.tar.gz"
      sha256 "e7ee81a38f8dd2e6737ab1c65bdeb4330d98b8082adb443a629e4429f826bedc"
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
