class AgentSalonRestart < Formula
  desc "Scheduled daily restart of agent-salon"
  homepage "https://github.com/m5d215/agent-salon"
  url "https://github.com/m5d215/homebrew-tap/archive/refs/tags/agent-salon-restart-v0.1.0.tar.gz"
  sha256 "2d77536b0e7a57724c38194b28447d61a92b0c5c919979acb0287d89154ddc9f"
  license "MIT"

  depends_on "m5d215/tap/agent-salon"

  def install
    doc.mkpath
    (doc/"README.md").write <<~EOS
      Schedules daily restart of agent-salon.

      Enable with:
        brew services start m5d215/tap/agent-salon-restart

      The restart runs at 04:00 local time via launchd and invokes
      `brew services restart agent-salon`.
    EOS
  end

  def post_install
    (var/"log").mkpath
  end

  service do
    run [HOMEBREW_PREFIX/"bin/brew", "services", "restart", "agent-salon"]
    run_type :cron
    cron "0 4 * * *"
    log_path var/"log/agent-salon-restart.log"
    error_log_path var/"log/agent-salon-restart.log"
  end

  test do
    assert_predicate doc/"README.md", :file?
  end
end
