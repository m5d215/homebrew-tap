class AgentSalon < Formula
  desc "Gathering place for Claude Code MCP sessions"
  homepage "https://github.com/m5d215/agent-salon"
  version "0.4.5"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m5d215/agent-salon/releases/download/v0.4.5/agent-salon-macos-arm64.tar.gz"
      sha256 "947ed821366eccdf02101275406195fa700b0c8c1d5d1b10dfcebd01fe55c100"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/agent-salon/releases/download/v0.4.5/agent-salon-linux-x86_64.tar.gz"
      sha256 "60d8fc7aa4c74b9f85ae085961c1257236b591ab00d07a6dd56898dca2c0a041"
    end
  end

  def install
    bin.install "agent-salon"
  end

  def post_install
    (var/"agent-salon").mkpath
    (var/"log").mkpath
    return if (etc/"agent-salon.conf").exist?

    (etc/"agent-salon.conf").write(<<~CONF)
      # agent-salon configuration
      # Format: KEY=VALUE per line. Lines starting with `#` and blank lines
      # are ignored. The live process environment overrides any value here.
      # See https://github.com/m5d215/agent-salon#config-file
      #
      # Common host-specific settings (uncomment and edit):
      #
      # AGENT_SALON_BIND=0.0.0.0
      # AGENT_SALON_ALLOWED_HOSTS=my-host.tailXXXXXX.ts.net,localhost,127.0.0.1
      # AGENT_SALON_ALIASES=notes:laptop-a,drafts:home-mac
    CONF
  end

  service do
    run [opt_bin/"agent-salon"]
    keep_alive true
    log_path var/"log/agent-salon.log"
    error_log_path var/"log/agent-salon.log"
    working_dir var/"agent-salon"
    environment_variables(
      AGENT_SALON_DB:     var/"agent-salon/agent-salon.db",
      AGENT_SALON_PORT:   "9315",
      AGENT_SALON_CONFIG: etc/"agent-salon.conf",
    )
  end

  test do
    assert_predicate bin/"agent-salon", :executable?
  end
end
