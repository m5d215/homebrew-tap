class MarkdownBrowser < Formula
  desc "Terminal markdown browser with first-class GFM table rendering"
  homepage "https://github.com/m5d215/markdown-browser"
  version "0.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m5d215/markdown-browser/releases/download/v0.4.0/markdown-browser-macos-arm64.tar.gz"
      sha256 "5fb07dd4ff33474a932dbf0259e5b6d88a81e4db8e9645480e7ae2758a56df0c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/markdown-browser/releases/download/v0.4.0/markdown-browser-linux-x86_64.tar.gz"
      sha256 "7fb697bd91408ab58a42f9087072f7281940863028fb9da23163242bf73bc10c"
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
