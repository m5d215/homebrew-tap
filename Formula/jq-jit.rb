class JqJit < Formula
  desc "JIT-compiling implementation of jq using Cranelift"
  homepage "https://github.com/m5d215/jq-jit"
  version "1.10.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.10.0/jq-jit-macos-arm64.tar.gz"
      sha256 "7e65dd4823eb81f1223ab0cfc09f53283d2f1974a9e12739e383d2d5bad73cb8"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.10.0/jq-jit-linux-x86_64.tar.gz"
      sha256 "3337fc787040ae9cbf1889b64504bb898cf94136dad4b6236eb6ae6288dfe7b0"
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
