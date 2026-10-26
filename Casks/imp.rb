cask "imp" do
  version "1.0.2"
  sha256 "18840c8a14cc07562f773027f7a73e0df18d6497f2d848c11259a9c2d8cf7329"

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
