cask "imp" do
  version "1.1.0"
  sha256 "8ca5bff286f585e3623c1dc1949622e71f4cf689f3af653d4b81298c0bb09a98"

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
