cask "imp" do
  version "1.12.0"
  sha256 "483b8d2e93a8414b10af76c4e649074cd4d0ac013192be7adc3a64257dc7b119"

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
