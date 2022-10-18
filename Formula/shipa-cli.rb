class ShipaCli < Formula
    desc "Shipa command-line interface"
    homepage "https://shipa.io/"
    license "Apache-2.0"
    version "1.8.0-rc2"

    platform = ""
    sha = ""
    root_url = "https://storage.googleapis.com/shipa-client/" + version + "/shipa_"

    darwin_amd64_sha256 = "cc8897298b99f935aa81bed93e6fbe5a52124a741753fe3b81e21d3e3a422698"
    linux_amd64_sha256 = "2cc539397e4520438ff6f49437ff086587a5d99501bbf252f0075fb03b388714"
    linux_386_sha256 = "b1615c7cf131bb2652005032857009c2eaffca314d070f645508adf977f04d03"

    os = OS.kernel_name.downcase
    arch = Hardware::CPU.intel? ? "amd64" : Hardware::CPU.arch.to_s
    
    if os == "darwin" && (arch == "amd64" || arch == "arm64")
        platform = "darwin_amd64"
        sha = darwin_amd64_sha256
    elsif os == "linux"
        if Hardware::CPU.is_64_bit?
            platform = "linux_amd64"
            sha = linux_amd64_sha256
        else # 32 bit install
            platform = "linux_386"
            sha = linux_386_sha256
        end
    end

    if platform == ""
        odie "Sorry, architecture not supported: See instructions on downloading Shipa Client from https://learn.shipa.io/docs/downloading-the-shipa-client"
    end

    sha256 sha
    url root_url + platform
  
    def install
        Dir["*"].each do |binary|
            File.rename(binary, "shipa")
        end
        bin.install "shipa"
    end
  
    test do
      system "#{bin}/shipa", "help"
    end
end