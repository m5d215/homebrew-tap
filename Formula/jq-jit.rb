class JqJit < Formula
  desc "JIT-compiling implementation of jq using Cranelift"
  homepage "https://github.com/m5d215/jq-jit"
  version "1.9.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.9.2/jq-jit-macos-arm64.tar.gz"
      sha256 "e3cfedab4cbc4ebffbd7777a9c34210746971c02fea9900cd29a395541bd8327"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.9.2/jq-jit-linux-x86_64.tar.gz"
      sha256 "76ec366c34dc7c90909c996946af96abec2619ae516b373b24a2b1b19b74e388"
    end
  end

  def install
    bin.install "jq-jit"
    pkgshare.install "LICENSE-MIT", "LICENSE-APACHE", "THIRD-PARTY-LICENSES.md"
    doc.install "README.md"
  end

  test do
    assert_match "jq-jit-", shell_output("#{bin}/jq-jit --version")
  end
end
