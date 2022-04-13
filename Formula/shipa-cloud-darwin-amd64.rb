class ShipaCloudDarwinAmd64 < Formula
    desc "Shipa command-line interface"
    homepage "https://shipa.io/"
    license "Apache-2.0"
    url "https://storage.googleapis.com/shipa-client-cloud/1.7.1-cloud/shipa_darwin_amd64"
    sha256 "36164c63ce4288a63a4b0e24031d82b0d4761f8efb4700b88149f18f5626cdbf"
  
    def install
      bin.install "shipa_darwin_amd64" => "shipa"
    end
  
    test do
      system "#{bin}/shipa", "help"
    end
end