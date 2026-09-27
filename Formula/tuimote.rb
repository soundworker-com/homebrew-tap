class Tuimote < Formula
  desc "Remote control for Claude Code and other agentic TUI apps"
  homepage "https://tuimote.org"
  version "1.0.2"
  license "AGPL-3.0-only"

  depends_on "tmux"
  uses_from_macos "git"

  on_macos do
    on_arm do
      url "https://github.com/soundworker-com/tuimote/releases/download/v1.0.2/tuimote-1.0.2-aarch64-apple-darwin.tar.gz"
      sha256 "2a050b3c8144236458542b73d8cee49009357db06e06ecfde384b2bb2cb3e270"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/soundworker-com/tuimote/releases/download/v1.0.2/tuimote-1.0.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "e49ff343cd391d0d884548b18bb223ad973b0b1effc6acdf21113dee902d33b3"
    end
    on_intel do
      url "https://github.com/soundworker-com/tuimote/releases/download/v1.0.2/tuimote-1.0.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e2ef84d0ff3edf89447d0e17de221ee24753d82d9700133b222e1348750eeef3"
    end
  end

  def install
    bin.install "tuimote", "tuimote-server"
    generate_completions_from_executable(bin/"tuimote", "completions")
  end

  def caveats
    <<~EOS
      Run `tuimote setup` to install the background service and scan your agent
      session directories. tuimote needs at least one supported agent harness
      (e.g. Claude Code) installed on this machine.

      After upgrading, run `tuimote setup` again to refresh and restart the
      background service on the newly installed version.
    EOS
  end

  test do
    assert_match "tuimote", shell_output("#{bin}/tuimote --version")
  end
end
