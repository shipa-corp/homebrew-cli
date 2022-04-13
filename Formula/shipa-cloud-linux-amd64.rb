class ShipaCloudLinuxAmd64 < Formula
    desc "Shipa command-line interface"
    homepage "https://shipa.io/"
    license "Apache-2.0"
    url "https://storage.googleapis.com/shipa-client-cloud/1.7.1-cloud/shipa_linux_amd64"
    sha256 "08b1034c70d8d11647a78991037691d1e0afc0c4ad53910ef1a004f701941645"

    def install
      bin.install "shipa_linux_amd64" => "shipa"
    end

    test do
      system "#{bin}/shipa", "help"
    end
end