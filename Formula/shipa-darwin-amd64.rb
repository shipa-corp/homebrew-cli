class Shipa < Formula
    desc "Shipa command-line interface"
    homepage "https://shipa.io/"
    license "Apache-2.0"
    url "https://storage.googleapis.com/shipa-client/1.7.0/shipa_darwin_amd64"
    sha256 "96535ad525837e1a47616264f7a78c1e74957b7c9b4e4578770c1e2540ec007b"
  
    def install
      bin.install "shipa_darwin_amd64" => "shipa"
    end
  
    test do
      system "#{bin}/shipa", "help"
    end
  end