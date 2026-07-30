class ClaudeStatusline < Formula
  desc "Status line and subagent panel renderer for Claude Code"
  homepage "https://github.com/m5d215/claude-statusline"
  url "https://github.com/m5d215/claude-statusline.git",
      tag: "v0.6.0"
  license "MIT"
  head "https://github.com/m5d215/claude-statusline.git", branch: "main"

  depends_on "m5d215/tap/jq-jit"

  def install
    bin.install "statusline.sh" => "claude-statusline"
    bin.install "subagent-statusline.sh" => "claude-subagent-statusline"
  end

  test do
    input = '{"model":{"display_name":"test"},"workspace":{"current_dir":"/tmp"}}'
    output = pipe_output(bin/"claude-statusline", input, 0)
    refute_empty output

    subagent_input = '{"tasks":[{"id":"x","label":"t","status":"running"}]}'
    subagent_output = pipe_output(bin/"claude-subagent-statusline", subagent_input, 0)
    assert_match(/"id":"x"/, subagent_output)
  end
end
