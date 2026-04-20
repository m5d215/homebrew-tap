class AgentSalon < Formula
  desc "Gathering place for Claude Code MCP sessions"
  homepage "https://github.com/m5d215/agent-salon"
  url "https://github.com/m5d215/agent-salon.git",
      tag: "v0.1.0"
  license "MIT"
  head "https://github.com/m5d215/agent-salon.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: ".")
  end

  service do
    run [opt_bin/"agent-salon"]
    keep_alive true
    log_path var/"log/agent-salon.log"
    error_log_path var/"log/agent-salon.log"
    working_dir var/"agent-salon"
    environment_variables(
      AGENT_SALON_DB: var/"agent-salon/agent-salon.db",
      AGENT_SALON_PORT: "9315"
    )
  end

  test do
    assert_predicate bin/"agent-salon", :executable?
  end
end
