class MarkdownBrowser < Formula
  desc "Terminal markdown browser with first-class GFM table rendering"
  homepage "https://github.com/m5d215/markdown-browser"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m5d215/markdown-browser/releases/download/v0.2.0/markdown-browser-macos-arm64.tar.gz"
      sha256 "625d00b1d2d714f5e217b97564f57d21d58d5f37dab5178f28f8f53da63ad856"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/markdown-browser/releases/download/v0.2.0/markdown-browser-linux-x86_64.tar.gz"
      sha256 "4cd5ecbb42c748d6ed3edfa4778f716e4228313209aedb96f07bae4a1585a4d8"
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
