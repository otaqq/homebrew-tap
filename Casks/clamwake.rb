cask "clamwake" do
  version "0.1.1"
  sha256 "500557c0fcd4c67f9e447f0b8337d5362caa5fcf3eae0768bda550211d498c65"

  url "https://github.com/otaqq/clamwake/archive/refs/tags/v#{version}.tar.gz"
  name "clamwake"
  desc "Keep a MacBook awake with the lid closed while on AC and on a home network"
  homepage "https://github.com/otaqq/clamwake"

  depends_on macos: :sonoma

  # install.sh copies the files into /usr/local (owned by root) and starts the LaunchDaemon
  installer script: {
    executable: "clamwake-#{version}/install.sh",
    sudo:       true,
  }

  # Keeps the settings and remembered home networks, so that an upgrade keeps them too
  uninstall script: {
    executable: "clamwake-#{version}/uninstall.sh",
    args:       ["--keep-data"],
    sudo:       true,
  }

  zap script: {
    executable: "clamwake-#{version}/uninstall.sh",
    sudo:       true,
  }

  caveats <<~EOS
    clamwake runs as a root LaunchDaemon (io.github.otaqq.clamwake). On the home network, run once:
      clamwake home add home
    Then check every input and the decision with:
      clamwake doctor
  EOS
end
