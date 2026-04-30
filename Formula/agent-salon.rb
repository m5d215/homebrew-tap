class AgentSalon < Formula
  desc "Gathering place for Claude Code MCP sessions"
  homepage "https://github.com/m5d215/agent-salon"
  url "https://github.com/m5d215/agent-salon.git",
      tag: "v0.4.4"
  license "MIT"
  head "https://github.com/m5d215/agent-salon.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: ".")
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
      AGENT_SALON_CONFIG: etc/"agent-salon.conf"
    )
  end

  test do
    assert_predicate bin/"agent-salon", :executable?
  end
end
