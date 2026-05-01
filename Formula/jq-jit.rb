class JqJit < Formula
  desc "JIT-compiling implementation of jq using Cranelift"
  homepage "https://github.com/m5d215/jq-jit"
  version "1.4.5"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.4.5/jq-jit-macos-arm64.tar.gz"
      sha256 "fbbe28c1b0060618b212f0dca7bb4b9e1687780b020ea7a818584f8f1fe96f5c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.4.5/jq-jit-linux-x86_64.tar.gz"
      sha256 "ce76a9e584dd4280a33ad438da4f93cd94aa65190b8ad51fa420579de31b8512"
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
