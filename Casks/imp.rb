cask "imp" do
  version "2.0.1"
  sha256 "25bf7ed923380a06b6350132b5b79d71278ca54c4686158ce1991970ba2d75e9"

  url "https://github.com/impsland/imp/releases/download/v#{version}/Imp.dmg"
  name "Imp"
  desc "Tiny desk imp that answers, talks and runs shell commands for you"
  homepage "https://github.com/impsland/imp"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Imp.app"

  # Imp is signed with its own certificate, not notarized by Apple: clear the download quarantine so Gatekeeper lets it open.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Imp.app"]
  end

  uninstall quit: "app.imp.Imp"

  zap trash: [
    "~/Library/Application Support/Imp",
    "~/Library/Preferences/app.imp.Imp.plist",
  ]
end
