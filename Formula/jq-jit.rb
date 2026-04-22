class JqJit < Formula
  desc "JIT-compiling implementation of jq using Cranelift"
  homepage "https://github.com/m5d215/jq-jit"
  version "1.2.1"
  license any_of: ["MIT", "Apache-2.0"]

  depends_on "jq"
  depends_on "oniguruma"

  on_macos do
    on_arm do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.2.1/jq-jit-macos-arm64.tar.gz"
      sha256 "e5096e8427e5ae9264f78b1f2dad3de75878d90c45fbc863562cb2f6cf7f91e2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.2.1/jq-jit-linux-x86_64.tar.gz"
      sha256 "05a43ba603594079edee4540fc17f149aee07b8f0f46c2ce3d3f0c8c5c6f41a3"
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
