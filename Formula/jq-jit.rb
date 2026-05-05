class JqJit < Formula
  desc "JIT-compiling implementation of jq using Cranelift"
  homepage "https://github.com/m5d215/jq-jit"
  version "1.5.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.5.1/jq-jit-macos-arm64.tar.gz"
      sha256 "5d18e30a231f85055e0058cfec29f54afb4530e482b144a4b1b15c96ab64dd55"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.5.1/jq-jit-linux-x86_64.tar.gz"
      sha256 "658744dc097d4b73a6bd77e223fd4f4c4a6a406d8073514e0c7f63b32e6a598f"
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
