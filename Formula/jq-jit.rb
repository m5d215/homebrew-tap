class JqJit < Formula
  desc "JIT-compiling implementation of jq using Cranelift"
  homepage "https://github.com/m5d215/jq-jit"
  version "1.8.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.8.2/jq-jit-macos-arm64.tar.gz"
      sha256 "0acb1fee599aba1990cb17daf41ff216ca1016328fac05c47d75a179fb51a4b3"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.8.2/jq-jit-linux-x86_64.tar.gz"
      sha256 "4a9e1206231c402f34fb28b33c52bc19c0ed31954bb9b0996e6f37b6c3ce7d91"
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
