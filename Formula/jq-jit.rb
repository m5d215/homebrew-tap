class JqJit < Formula
  desc "JIT-compiling implementation of jq using Cranelift"
  homepage "https://github.com/m5d215/jq-jit"
  version "1.4.4"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.4.4/jq-jit-macos-arm64.tar.gz"
      sha256 "9768597037da31b9447d51ce9b18f43ae7d504b599b4fcc5fedeba13d0e1eac4"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.4.4/jq-jit-linux-x86_64.tar.gz"
      sha256 "b7f385c69cd2ca7011a52a08ca4d84fdc977a0cd1e36598cb5b416502822f5eb"
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
