class Shipa < Formula
  desc "Shipa command-line interface"
  homepage "https://shipa.io/"
  license "Apache-2.0"
  url "https://storage.googleapis.com/shipa-client/1.7.0/shipa_linux_amd64"
  sha256 "d18454385433e664ac0c8042029e6a6185cae3077df0dd8477c10c6a029e3013"

  def install
    bin.install "shipa_linux_amd64" => "shipa"
  end

  test do
    system "#{bin}/shipa", "help"
  end
end