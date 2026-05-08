class AgentSalonSlack < Formula
  desc "Bridge between Slack and Claude Code sessions via agent-salon"
  homepage "https://github.com/m5d215/agent-salon-slack"
  version "0.1.5"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m5d215/agent-salon-slack/releases/download/v0.1.5/agent-salon-slack-macos-arm64.tar.gz"
      sha256 "de0c902fc58860252890454a86800b75fcf17a6d39b18b7621a65f8711d103fd"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/agent-salon-slack/releases/download/v0.1.5/agent-salon-slack-linux-x86_64.tar.gz"
      sha256 "dd5d4872ce56c31fdad00e01d6d67efbcc19806d76887f86bf3cab3dc502eb6e"
    end
  end

  def install
    bin.install "agent-salon-slack"
    pkgshare.install "LICENSE", "THIRD-PARTY-LICENSES.md", "manifest.yml", ".env.example"
    doc.install "README.md"
  end

  def post_install
    (var/"agent-salon-slack").mkpath
    (var/"log").mkpath
    return if (etc/"agent-salon-slack.conf").exist?

    (etc/"agent-salon-slack.conf").write(<<~CONF)
      # agent-salon-slack configuration
      # Format: KEY=VALUE per line. Lines starting with `#` and blank lines
      # are ignored. The live process environment overrides any value here.
      # See https://github.com/m5d215/agent-salon-slack#environment-variables
      #
      # Required (the service will not start until these are set):
      #
      # SLACK_APP_TOKEN=xapp-...
      # SLACK_BOT_TOKEN=xoxb-...
      # AGENT_SALON_URL=http://127.0.0.1:9315/notify
      # AGENT_SALON_LABEL=agent-salon-slack
      # AGENT_SALON_TARGET=main
      #
      # Optional (defaults shown):
      #
      # AGENT_SALON_SLACK_HTTP_PORT=8765
      # AGENT_SALON_SLACK_HTTP_BIND=127.0.0.1
      # OLLAMA_URL=http://localhost:11434
      # OLLAMA_MODEL=llama-guard3:1b
      # INJECTION_BLOCK_THRESHOLD=0.7
      # INJECTION_WARN_THRESHOLD=0.5
      # INJECTION_TIMEOUT_SECS=30
    CONF
    (etc/"agent-salon-slack.conf").chmod(0600)
  end

  def caveats
    <<~EOS
      Configuration:
        #{etc}/agent-salon-slack.conf

      The required Slack and agent-salon settings are commented out by
      default — fill them in before starting the service.
    EOS
  end

  service do
    run [opt_bin/"agent-salon-slack"]
    keep_alive true
    log_path var/"log/agent-salon-slack.log"
    error_log_path var/"log/agent-salon-slack.log"
    working_dir var/"agent-salon-slack"
    environment_variables(
      AGENT_SALON_SLACK_CONFIG: etc/"agent-salon-slack.conf",
    )
  end

  test do
    output = shell_output("#{bin}/agent-salon-slack 2>&1", 1)
    assert_match "startup.fatal", output
  end
end
