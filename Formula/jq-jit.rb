class JqJit < Formula
  desc "JIT-compiling implementation of jq using Cranelift"
  homepage "https://github.com/m5d215/jq-jit"
  version "1.11.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.11.0/jq-jit-macos-arm64.tar.gz"
      sha256 "c34338f51a0bd63841e06acc81fac1f5cceae602efb5b332dbccfa6d9e850568"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.11.0/jq-jit-linux-x86_64.tar.gz"
      sha256 "02d139072c915a6ad8f35e5e5717d005e29529640797e71f6e6351daa2c66719"
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
