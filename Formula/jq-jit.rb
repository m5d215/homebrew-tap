class JqJit < Formula
  desc "JIT-compiling implementation of jq using Cranelift"
  homepage "https://github.com/m5d215/jq-jit"
  version "1.4.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.4.1/jq-jit-macos-arm64.tar.gz"
      sha256 "f84c9ccf609ad9ad9d4046e4fc92e1d0da624c87b53fa33c12aad4b8833ca1a9"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.4.1/jq-jit-linux-x86_64.tar.gz"
      sha256 "95141ec8f7088934fdc3d92a278427c9dc0f92d587a0b10c8a46967f94cde960"
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
