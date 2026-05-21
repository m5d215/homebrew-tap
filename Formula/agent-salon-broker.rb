class AgentSalonBroker < Formula
  desc "Broker daemon for claude -p-style jobs via agent-salon"
  homepage "https://github.com/m5d215/agent-salon-broker"
  version "0.5.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m5d215/agent-salon-broker/releases/download/v0.5.0/agent-salon-broker-macos-arm64.tar.gz"
      sha256 "5635514272833990b1813e4e1103dbff9c9f398d139ba0a7c2d51de58915154f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/agent-salon-broker/releases/download/v0.5.0/agent-salon-broker-linux-x86_64.tar.gz"
      sha256 "88a849b3ecb92427e10170e56fb2015f4e979054e38d45f0b3d946836cf5bc7d"
    end
  end

  def install
    bin.install "agent-salon-broker"
  end

  def post_install
    (var/"agent-salon-broker").mkpath
    (var/"log").mkpath
    return if (etc/"agent-salon-broker.conf").exist?

    (etc/"agent-salon-broker.conf").write(<<~CONF)
      # agent-salon-broker configuration
      # Format: KEY=VALUE per line. Lines starting with `#` and blank lines
      # are ignored. The live process environment overrides any value here.
      # See https://github.com/m5d215/agent-salon-broker#config-file
      #
      # Common host-specific settings (uncomment and edit):
      #
      # AGENT_SALON_URL=http://127.0.0.1:9315/mcp?label=broker
      # AGENT_SALON_BROKER_TARGET=claudep
      # AGENT_SALON_BROKER_LISTEN=127.0.0.1:9316
      # AGENT_SALON_BROKER_TIMEOUT_SEC=600
      #
      # To accept requests from other devices on a Tailnet:
      # AGENT_SALON_BROKER_LISTEN=0.0.0.0:9316
    CONF
  end

  service do
    run [opt_bin/"agent-salon-broker"]
    keep_alive true
    log_path var/"log/agent-salon-broker.log"
    error_log_path var/"log/agent-salon-broker.log"
    working_dir var/"agent-salon-broker"
    environment_variables(
      AGENT_SALON_BROKER_CONFIG:    etc/"agent-salon-broker.conf",
      AGENT_SALON_BROKER_JSONL_LOG: var/"log/agent-salon-broker.jsonl",
    )
  end

  test do
    assert_predicate bin/"agent-salon-broker", :executable?
  end
end
