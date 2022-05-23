class ShipaCli < Formula
    desc "Shipa command-line interface"
    homepage "https://shipa.io/"
    license "Apache-2.0"
    version "1.7.7"

    platform = ""
    sha = ""
    root_url = "https://storage.googleapis.com/shipa-client/" + version + "/shipa_"

    darwin_amd64_sha256 = "257da49d3bd9325d5c2f43e394bb0161312112e68bfb84c1722e8c836eb82a32"
    linux_amd64_sha256 = "a8a9184fd79fa48a32b305c86f5528631e77f6dfa362604fbb83ac76277084ac"
    linux_386_sha256 = "96e5fa29d83abe8ab52519be0255735c8e09d4a0a18b644d68ea756bcb7cfb14"

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