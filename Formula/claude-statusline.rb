class ClaudeStatusline < Formula
  desc "Powerline-style status line for Claude Code (single jq-jit program)"
  homepage "https://github.com/m5d215/claude-statusline"
  url "https://github.com/m5d215/claude-statusline.git",
      tag: "v0.1.2"
  license "MIT"
  head "https://github.com/m5d215/claude-statusline.git", branch: "main"

  depends_on "m5d215/tap/jq-jit"

  def install
    bin.install "statusline.sh" => "claude-statusline"
  end

  test do
    input = '{"model":{"display_name":"test"},"workspace":{"current_dir":"/tmp"}}'
    output = pipe_output(bin/"claude-statusline", input, 0)
    refute_empty output
  end
end
