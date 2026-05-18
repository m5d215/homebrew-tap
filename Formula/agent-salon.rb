class AgentSalon < Formula
  desc "Gathering place for Claude Code MCP sessions"
  homepage "https://github.com/m5d215/agent-salon"
  version "0.5.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m5d215/agent-salon/releases/download/v0.5.0/agent-salon-macos-arm64.tar.gz"
      sha256 "45a7c85ea746743a94eecd3b3693faa602f809730f1df26ef082e221eebf7496"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/agent-salon/releases/download/v0.5.0/agent-salon-linux-x86_64.tar.gz"
      sha256 "9dc13b2f6ff0bb7d3a107a2b667e990e2fdb7754de6fbd5b487e1fbf272e5cc3"
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
      AGENT_SALON_DB:         var/"agent-salon/agent-salon.db",
      AGENT_SALON_PORT:       "9315",
      AGENT_SALON_CONFIG:     etc/"agent-salon.conf",
      AGENT_SALON_JSONL_LOG:  var/"log/agent-salon.jsonl",
    )
  end

  test do
    assert_predicate bin/"agent-salon", :executable?
  end
end
