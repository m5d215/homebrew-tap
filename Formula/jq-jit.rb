class JqJit < Formula
  desc "JIT-compiling implementation of jq using Cranelift"
  homepage "https://github.com/m5d215/jq-jit"
  version "1.2.0"
  license any_of: ["MIT", "Apache-2.0"]

  depends_on "jq"
  depends_on "oniguruma"

  on_macos do
    on_arm do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.2.0/jq-jit-macos-arm64.tar.gz"
      sha256 "f23311b9f2ea29a6425d52966f8bd8a08fa196d510547e200c9d4ea2d0307cb6"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.2.0/jq-jit-linux-x86_64.tar.gz"
      sha256 "1b785738e47272ec65b2eadceacce54105a70f1de269cf98481df55d808982dd"
    end
  end

  def install
    bin.install "jq-jit"
  end

  test do
    assert_match "jq-jit-", shell_output("#{bin}/jq-jit --version")
  end
end
