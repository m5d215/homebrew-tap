class JqJit < Formula
  desc "JIT-compiling implementation of jq using Cranelift"
  homepage "https://github.com/m5d215/jq-jit"
  version "1.7.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.7.1/jq-jit-macos-arm64.tar.gz"
      sha256 "00b14c61d637241f45c7547a77bb0d8d885d28f7d5409d8833b9be32910231b2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.7.1/jq-jit-linux-x86_64.tar.gz"
      sha256 "947ee0fc02ca78c6c4149e20e5777a722f131d32a0280acb9e602e52bdaa3611"
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
