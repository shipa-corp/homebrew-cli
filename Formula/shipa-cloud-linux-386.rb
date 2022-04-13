class ShipaCloudLinux386 < Formula
    desc "Shipa command-line interface"
    homepage "https://shipa.io/"
    license "Apache-2.0"
    url "https://storage.googleapis.com/shipa-client-cloud/1.7.1-cloud/shipa_linux_386"
    sha256 "bef6507b6d0843f9d0b777fa47fb0c962190a19823bc5c842fbfaf8218e2618a"
  
    def install
      bin.install "shipa_linux_386" => "shipa"
    end
  
    test do
      system "#{bin}/shipa", "help"
    end
  end