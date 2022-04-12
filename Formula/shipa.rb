class Shipa < Formula
    desc "Shipa command-line interface"
    homepage "https://shipa.io/"
    url ""
    sha256 ""
  
    def install
      bin.install "shipa"
    end
  
    test do
      system "#{bin}/shipa", "help"
    end
  end