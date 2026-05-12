class JqJit < Formula
  desc "JIT-compiling implementation of jq using Cranelift"
  homepage "https://github.com/m5d215/jq-jit"
  version "1.5.6"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.5.6/jq-jit-macos-arm64.tar.gz"
      sha256 "b5fa90964e5b7cd75f8e9c3f852bd5871fc89e7a0c0f8bd6da54be431245f098"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/jq-jit/releases/download/v1.5.6/jq-jit-linux-x86_64.tar.gz"
      sha256 "b78f8c1095f2100c9eddf533a97b53f6ce5d0151ec5b8149fc1455cbd0374d42"
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
