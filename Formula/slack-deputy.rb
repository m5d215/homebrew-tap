class SlackDeputy < Formula
  desc "Personal agent that handles your Slack as yourself"
  homepage "https://github.com/m5d215/slack-deputy"
  version "0.0.5"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/m5d215/slack-deputy/releases/download/v0.0.5/slack-deputy-macos-arm64.tar.gz"
      sha256 "bb55b2ff0c1b58a568d83f55d64b6e0b41596ce70666d77ff4d8deddd7aad1b7"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/m5d215/slack-deputy/releases/download/v0.0.5/slack-deputy-linux-x86_64.tar.gz"
      sha256 "9df53d41a645147e7575fa759e3e027a7cd1e05c2080758f3eb17cfffeea8667"
    end
  end

  def install
    bin.install "slack-deputy"
  end

  def post_install
    (var/"slack-deputy").mkpath
    (var/"log").mkpath
    return if (etc/"slack-deputy.conf").exist?

    (etc/"slack-deputy.conf").write(<<~CONF)
      # slack-deputy configuration
      # Format: KEY=VALUE per line. Lines starting with `#` and blank lines
      # are ignored. The live process environment overrides any value here.
      # See https://github.com/m5d215/slack-deputy#configuration
      #
      # Required — Slack tokens (see the repo's setup steps):
      # SLACK_APP_TOKEN=xapp-...
      # SLACK_BOT_TOKEN=xoxb-...
      # SLACK_USER_TOKEN=xoxp-...
      #
      # Optional — capture channels even without a mention:
      # SLACK_DEPUTY_WATCH_CHANNELS=C0123456789,C0234567890
      #
      # Optional — let a consumer on another device drive the daemon over a
      # trusted tailnet (no app auth; bind only inside the tailnet):
      # SLACK_DEPUTY_LISTEN=0.0.0.0:8799
    CONF
  end

  service do
    run [opt_bin/"slack-deputy"]
    keep_alive true
    log_path var/"log/slack-deputy.log"
    error_log_path var/"log/slack-deputy.log"
    working_dir var/"slack-deputy"
    environment_variables(
      SLACK_DEPUTY_CONFIG: etc/"slack-deputy.conf",
      SLACK_DEPUTY_DB:     var/"slack-deputy/slack-deputy.db",
    )
  end

  test do
    assert_predicate bin/"slack-deputy", :executable?
  end
end
