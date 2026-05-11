class JqJit < Formula
  desc "JIT-compiling implementation of jq using Cranelift"
  homepage "https://github.com/m5d215/jq-jit"
  version "1.5.5"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.5.5/jq-jit-macos-arm64.tar.gz"
      sha256 "499a22e2a119682353fe1a6bd3b1eb9aaf49197fb1f8beb940961c5eb7b2bbb1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.5.5/jq-jit-linux-x86_64.tar.gz"
      sha256 "c5bbf116ac44167b5a3c925767507569346270b18548d9c43861709ed77e6b72"
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
