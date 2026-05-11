class JqJit < Formula
  desc "JIT-compiling implementation of jq using Cranelift"
  homepage "https://github.com/m5d215/jq-jit"
  version "1.5.4"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.5.4/jq-jit-macos-arm64.tar.gz"
      sha256 "3afd0cdad66e1a58f5b97fe16daf5b2c6a4d29b2ebb93351a332a8131981a2e2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.5.4/jq-jit-linux-x86_64.tar.gz"
      sha256 "1cb1bfcd21a2dd521f0ddb47b95b149d1fecc4f978d4a467a120c2b2e09b993e"
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
