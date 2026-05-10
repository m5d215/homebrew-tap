class JqJit < Formula
  desc "JIT-compiling implementation of jq using Cranelift"
  homepage "https://github.com/m5d215/jq-jit"
  version "1.5.3"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.5.3/jq-jit-macos-arm64.tar.gz"
      sha256 "7b5a259c782fdce97ccad7c295546a4377d1a693a35597bdd07d9de78f239318"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.5.3/jq-jit-linux-x86_64.tar.gz"
      sha256 "d69e7252b8a20711e15e7003f11e472076ca3760962a0bfc6d6345a718c41f88"
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
