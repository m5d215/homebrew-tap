class JqJit < Formula
  desc "JIT-compiling implementation of jq using Cranelift"
  homepage "https://github.com/m5d215/jq-jit"
  version "1.4.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.4.0/jq-jit-macos-arm64.tar.gz"
      sha256 "f84fce914182ba275a91c25247b287dcca0386b8a63ba13afbbc27c652965f36"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.4.0/jq-jit-linux-x86_64.tar.gz"
      sha256 "f62a0af890876626e78e0cdc2e3f8ee62c68266d18bf7d0236b37274363a3958"
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
