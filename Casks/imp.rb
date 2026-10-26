cask "imp" do
  version "1.0.0"
  sha256 "0af6ef34a58e7f611b1f02316a802254908a061836a88fe0955d25f52f2905b6"

  url "https://github.com/impsland/imp/releases/download/v#{version}/Imp.zip"
  name "Imp"
  desc "Tiny desk imp that answers, talks and runs shell commands for you"
  homepage "https://github.com/impsland/imp"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Imp.app"

  # Imp is ad-hoc signed, not notarized: clear the download quarantine so Gatekeeper lets it open.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Imp.app"]
  end

  uninstall quit: "app.imp.Imp"

  zap trash: [
    "~/Library/Application Support/Imp",
    "~/Library/Preferences/app.imp.Imp.plist",
  ]
end
