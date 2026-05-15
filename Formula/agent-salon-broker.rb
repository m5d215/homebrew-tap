class AgentSalonBroker < Formula
  desc "Broker daemon for claude -p-style jobs via agent-salon"
  homepage "https://github.com/m5d215/agent-salon-broker"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m5d215/agent-salon-broker/releases/download/v0.1.0/agent-salon-broker-macos-arm64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/agent-salon-broker/releases/download/v0.1.0/agent-salon-broker-linux-x86_64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  def install
    bin.install "agent-salon-broker"
  end

  def post_install
    (var/"agent-salon-broker").mkpath
    (var/"log").mkpath
  end

  service do
    run [opt_bin/"agent-salon-broker"]
    keep_alive true
    log_path var/"log/agent-salon-broker.log"
    error_log_path var/"log/agent-salon-broker.log"
    working_dir var/"agent-salon-broker"
    environment_variables(
      AGENT_SALON_URL:              "http://127.0.0.1:9315/mcp?label=broker",
      AGENT_SALON_BROKER_LISTEN:    "127.0.0.1:9316",
      AGENT_SALON_BROKER_TARGET:    "claudep",
    )
  end

  test do
    assert_predicate bin/"agent-salon-broker", :executable?
  end
end
