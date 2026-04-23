class JqJit < Formula
  desc "JIT-compiling implementation of jq using Cranelift"
  homepage "https://github.com/m5d215/jq-jit"
  version "1.3.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.3.0/jq-jit-macos-arm64.tar.gz"
      sha256 "3af7ee818006438755e4de9abc1f2bbff4edd2e643ed9a090d23e3e0eb90620a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.3.0/jq-jit-linux-x86_64.tar.gz"
      sha256 "4b99c9d74ddd26260d616e1f6f25e38bcfdbae24cc224ba476bbd31611411377"
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
