class JqJit < Formula
  desc "JIT-compiling implementation of jq using Cranelift"
  homepage "https://github.com/m5d215/jq-jit"
  version "1.8.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.8.1/jq-jit-macos-arm64.tar.gz"
      sha256 "a9cfb69349c320322a346925a68faaaa9a15aabae820daa525d09960d502bfd1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.8.1/jq-jit-linux-x86_64.tar.gz"
      sha256 "3e25e36947b71ab32c54a926327e3ce908dc47995f35bbff66a48bc9de5f9dba"
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
