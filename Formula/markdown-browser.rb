class MarkdownBrowser < Formula
  desc "Terminal markdown browser with first-class GFM table rendering"
  homepage "https://github.com/m5d215/markdown-browser"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m5d215/markdown-browser/releases/download/v0.1.0/markdown-browser-macos-arm64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/markdown-browser/releases/download/v0.1.0/markdown-browser-linux-x86_64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
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
