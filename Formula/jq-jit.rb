class JqJit < Formula
  desc "JIT-compiling implementation of jq using Cranelift"
  homepage "https://github.com/m5d215/jq-jit"
  version "1.5.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.5.2/jq-jit-macos-arm64.tar.gz"
      sha256 "d925dfdeae987e23f5bca18b0de365a211d220ed991c1896163234be51300116"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.5.2/jq-jit-linux-x86_64.tar.gz"
      sha256 "5d508b137d3d4f7d197369324d8977781a4e4bb3532f835a8ee8f3bc0f45f01c"
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
