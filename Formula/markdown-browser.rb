class MarkdownBrowser < Formula
  desc "Terminal markdown browser with first-class GFM table rendering"
  homepage "https://github.com/m5d215/markdown-browser"
  version "0.2.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m5d215/markdown-browser/releases/download/v0.2.1/markdown-browser-macos-arm64.tar.gz"
      sha256 "761677a27cd8c4d947e41dd0a9c869796bf6692069c4589eeb33266dd8115318"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/markdown-browser/releases/download/v0.2.1/markdown-browser-linux-x86_64.tar.gz"
      sha256 "8ca4677be59e3b1c19b5ac749a64155af47f3effdb0a1670f096854a20ce6324"
    end
  end

  def install
    bin.install "markdown-browser"
    pkgshare.install "LICENSE-MIT"
    doc.install "README.md"
  end

  test do
    assert_match "markdown-browser ", shell_output("#{bin}/markdown-browser --version")
  end
end
