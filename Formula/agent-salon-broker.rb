class AgentSalonBroker < Formula
  desc "Broker daemon for claude -p-style jobs via agent-salon"
  homepage "https://github.com/m5d215/agent-salon-broker"
  version "0.3.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m5d215/agent-salon-broker/releases/download/v0.3.1/agent-salon-broker-macos-arm64.tar.gz"
      sha256 "7fb2f4e57fa7697a79d5cbcb4878132bfaa6007478573b4a5bdd4b3ff56f250f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/agent-salon-broker/releases/download/v0.3.1/agent-salon-broker-linux-x86_64.tar.gz"
      sha256 "ad3b0955c0d0acc2c0de340d9ee86805beaf58fc0c30eab2b26e35443a9b288e"
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
