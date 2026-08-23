class Tuimote < Formula
  desc "Remote control for Claude Code and other agentic TUI apps"
  homepage "https://tuimote.org"
  version "1.0.1"
  license "AGPL-3.0-only"

  depends_on "tmux"
  uses_from_macos "git"

  on_macos do
    on_arm do
      url "https://github.com/soundworker-com/tuimote/releases/download/v1.0.1/tuimote-1.0.1-aarch64-apple-darwin.tar.gz"
      sha256 "76cbd5155699ee6ff6db79cbdb86b634f34027cfc777f5c4520f0573141a7cdb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/soundworker-com/tuimote/releases/download/v1.0.1/tuimote-1.0.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f05c5bdd320c411465682bbb9084555607108f739cc810349a013bf5cbdc428a"
    end
    on_intel do
      url "https://github.com/soundworker-com/tuimote/releases/download/v1.0.1/tuimote-1.0.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a4d8d0cc98dbb6efa1c4a34d71b77c3abc3ee130c1e4b6feb7ec519ccd6b7281"
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
