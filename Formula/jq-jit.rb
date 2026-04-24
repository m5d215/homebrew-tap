class JqJit < Formula
  desc "JIT-compiling implementation of jq using Cranelift"
  homepage "https://github.com/m5d215/jq-jit"
  version "1.3.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.3.2/jq-jit-macos-arm64.tar.gz"
      sha256 "378cbbc9210a6ab090c6ba30c93face655bba473a29120724080c42ab71c95f6"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.3.2/jq-jit-linux-x86_64.tar.gz"
      sha256 "0509cd5b37844c4a2ed961aeabc586a05967a1187cd6a8be5533a2324fc68766"
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
