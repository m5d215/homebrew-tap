class JqJit < Formula
  desc "JIT-compiling implementation of jq using Cranelift"
  homepage "https://github.com/m5d215/jq-jit"
  version "1.8.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.8.0/jq-jit-macos-arm64.tar.gz"
      sha256 "a92c480f17241352a18f6f50fce47285b1d6e8bc043f97ba94e01b5f4bf2f0a0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.8.0/jq-jit-linux-x86_64.tar.gz"
      sha256 "b524d4baaa3cc6839cb3ef9884171964c9616a55044ee070ee755efe4bf3f28a"
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
