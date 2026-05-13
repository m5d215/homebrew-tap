class JqJit < Formula
  desc "JIT-compiling implementation of jq using Cranelift"
  homepage "https://github.com/m5d215/jq-jit"
  version "1.6.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.6.0/jq-jit-macos-arm64.tar.gz"
      sha256 "f1d806f0e445591cce23028772a5769caac46090758ffcea5f49d102c607a4e9"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.6.0/jq-jit-linux-x86_64.tar.gz"
      sha256 "6ca9922664bfd75aa137ecdf32f324061a726f60873802130b57b665d92bc54f"
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
