class Shutter < Formula
  desc "HTTP daemon that returns a JPEG frame from an avfoundation camera via ffmpeg"
  homepage "https://github.com/m5d215/shutter"
  version "0.1.0"
  license "MIT"

  depends_on "ffmpeg"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://github.com/m5d215/shutter/releases/download/v0.1.0/shutter-macos-arm64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  def install
    bin.install "shutter"
  end

  def post_install
    (var/"log").mkpath
    return if (etc/"shutter.conf").exist?

    (etc/"shutter.conf").write(<<~CONF)
      # shutter configuration
      # Format: KEY=VALUE per line. Lines starting with `#` and blank lines
      # are ignored. The live process environment overrides any value here.
      # See https://github.com/m5d215/shutter#configuration
      #
      # Required:
      # SHUTTER_DEVICE=MX Brio
      #
      # Optional (uncomment to override defaults):
      # SHUTTER_LISTEN_ADDR=127.0.0.1:9998
      # SHUTTER_VIDEO_SIZE=3840x2160
      # SHUTTER_FRAMERATE=30
      # SHUTTER_CAPTURE_TIMEOUT=10s
    CONF
  end

  service do
    run [opt_bin/"shutter"]
    keep_alive true
    log_path var/"log/shutter.log"
    error_log_path var/"log/shutter.log"
    environment_variables(
      SHUTTER_CONFIG: etc/"shutter.conf",
      SHUTTER_FFMPEG: HOMEBREW_PREFIX/"bin/ffmpeg",
    )
  end

  test do
    assert_predicate bin/"shutter", :executable?
  end
end
