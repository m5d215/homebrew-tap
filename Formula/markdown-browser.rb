class MarkdownBrowser < Formula
  desc "Terminal markdown browser with first-class GFM table rendering"
  homepage "https://github.com/m5d215/markdown-browser"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m5d215/markdown-browser/releases/download/v0.1.0/markdown-browser-macos-arm64.tar.gz"
      sha256 "684d05e23f484d9fa867da7d35511a62bb29d4e295623a537f48804752fa364a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/markdown-browser/releases/download/v0.1.0/markdown-browser-linux-x86_64.tar.gz"
      sha256 "db9fabf3589837c56fd7514b1941005a70badece14a265c15b033fde7c465f5d"
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
