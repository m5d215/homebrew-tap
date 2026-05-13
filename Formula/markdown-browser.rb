class MarkdownBrowser < Formula
  desc "Terminal markdown browser with first-class GFM table rendering"
  homepage "https://github.com/m5d215/markdown-browser"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m5d215/markdown-browser/releases/download/v0.3.0/markdown-browser-macos-arm64.tar.gz"
      sha256 "5eaddfa0d8b896981a112ce7b19059116fcc55601c1f6bcfc414d25144a0e2ab"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/markdown-browser/releases/download/v0.3.0/markdown-browser-linux-x86_64.tar.gz"
      sha256 "d57ea36d4c5becac575720fbba46f083434dc8af9cd991fc53cf82ab57a5994a"
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
