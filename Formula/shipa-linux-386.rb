class Shipa < Formula
    desc "Shipa command-line interface"
    homepage "https://shipa.io/"
    license "Apache-2.0"
    url "https://storage.googleapis.com/shipa-client/1.7.0/shipa_linux_386"
    sha256 "093c865e10d75bcda4248b9e410bafdcec9ddc3eee2c76245b8adbf13b125bc0"
  
    def install
      bin.install "shipa_linux_386" => "shipa"
    end
  
    test do
      system "#{bin}/shipa", "help"
    end
  end