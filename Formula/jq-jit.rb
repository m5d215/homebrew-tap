class JqJit < Formula
  desc "JIT-compiling implementation of jq using Cranelift"
  homepage "https://github.com/m5d215/jq-jit"
  version "1.6.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.6.1/jq-jit-macos-arm64.tar.gz"
      sha256 "986183f39548cf03cafe37bc110f6fd22988bc74b2d949f9a2350d7d2d126ef1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.6.1/jq-jit-linux-x86_64.tar.gz"
      sha256 "cc178596d2008abca71a453bec12ad4a5c7caf950127468cbd1e3afab52564bc"
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
