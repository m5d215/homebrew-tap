class JqJit < Formula
  desc "JIT-compiling implementation of jq using Cranelift"
  homepage "https://github.com/m5d215/jq-jit"
  version "1.4.3"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.4.3/jq-jit-macos-arm64.tar.gz"
      sha256 "6e074b476777a3ad92265d28111b34b56e3ba0c4c79cbdcb367f641e5d0a06ce"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.4.3/jq-jit-linux-x86_64.tar.gz"
      sha256 "a79d0a28028d956f0b2ebce49f39ffe464d64dc7c6e42f5840a292bbcc5dcbcd"
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
