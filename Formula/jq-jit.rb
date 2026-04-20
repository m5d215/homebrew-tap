class JqJit < Formula
  desc "JIT-compiling implementation of jq using Cranelift"
  homepage "https://github.com/m5d215/jq-jit"
  version "1.1.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.1.1/jq-jit-macos-arm64.tar.gz"
      sha256 "4bf273726f7ea7ed69fdb4e0f7525c084b297869202f27b66e7577965b85df9e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.1.1/jq-jit-linux-x86_64.tar.gz"
      sha256 "19a5963a33351c7bb1b3fed5946682c608d63291da897a7a6b5effd38c775fe0"
    end
  end

  def install
    bin.install "jq-jit"
  end

  test do
    assert_match "jq-jit-", shell_output("#{bin}/jq-jit --version")
  end
end
