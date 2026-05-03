class JqJit < Formula
  desc "JIT-compiling implementation of jq using Cranelift"
  homepage "https://github.com/m5d215/jq-jit"
  version "1.5.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.5.0/jq-jit-macos-arm64.tar.gz"
      sha256 "630e44ee8b16948e41afeeb06d8c62d27470c0ab355d1bd8a4c7b7b06b488b03"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.5.0/jq-jit-linux-x86_64.tar.gz"
      sha256 "d92f5041d40dd370464bdbef5ab78b65eeb3f2b55200b22645c486ff0b7b2351"
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
