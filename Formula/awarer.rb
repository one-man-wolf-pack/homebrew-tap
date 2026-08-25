# The tap copy of this file is generated from packaging/homebrew/awarer.rb.tmpl in
# one-man-wolf-pack/awarer. Edit the template there; a tap edit is overwritten by the
# next release.
class Awarer < Formula
  desc "Local worktree checkpoints, comparisons, and run evidence for coding agents"
  homepage "https://awarer.one-man-wolf-pack.com/"
  # The tag names the release and the revision pins the exact commit it pointed at, so a
  # moved tag cannot change what this formula compiles.
  url "https://github.com/one-man-wolf-pack/awarer.git",
      tag:      "v0.3.1",
      revision: "da0b5185973d2779d729586ccc9c088afebe504e"
  license "Apache-2.0"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    # The framed stamp is the one injection point awa reads; -s -w and -trimpath come from
    # std_go_args. A build without it reports 0.0.0-dev, which is not what a tap installs.
    ldflags = "-X awarer/internal/app.versionStamp=awa.version=v0.3.1"
    system "go", "build", *std_go_args(output: bin/"awa", ldflags: ldflags), "./cmd/awa"
    pkgshare.install "LICENSE", "THIRD_PARTY_NOTICES"
  end

  test do
    assert_match "v0.3.1", shell_output("#{bin}/awa version")
  end
end
