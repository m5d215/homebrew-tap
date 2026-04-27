class JqJit < Formula
  desc "JIT-compiling implementation of jq using Cranelift"
  homepage "https://github.com/m5d215/jq-jit"
  version "1.4.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.4.2/jq-jit-macos-arm64.tar.gz"
      sha256 "100ff235d6645753d03f4688ae71a7a4b254d29014166a3721ad3bd700eef5fc"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.4.2/jq-jit-linux-x86_64.tar.gz"
      sha256 "48f24fa41174676f46f541b994eb6ded285acf77abaacbc3769f4643c85e1d07"
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
