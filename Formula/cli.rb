class Cli < Formula
    desc "Shipa command-line interface"
    homepage "https://shipa.io/"
    license "Apache-2.0"

    sha = ""
    root_url = "https://storage.googleapis.com/shipa-client/1.7.0/shipa_"

    darwin_amd64_sha256 = "96535ad525837e1a47616264f7a78c1e74957b7c9b4e4578770c1e2540ec007b"
    linux_amd64_sha256 = "d18454385433e664ac0c8042029e6a6185cae3077df0dd8477c10c6a029e3013"
    linux_386_sha256 = "093c865e10d75bcda4248b9e410bafdcec9ddc3eee2c76245b8adbf13b125bc0"

    os = OS.kernel_name.downcase
    arch = Hardware::CPU.intel? ? "amd64" : Hardware::CPU.arch.to_s
    
    if os == "darwin" && (arch == "amd64" || arch == "arm64")
        root_url += "darwin_amd64"
        sha = darwin_amd64_sha256
    elsif os == "linux"
        if Hardware::CPU.is_64_bit?
            root_url += "linux_amd64"
            sha = linux_amd64_sha256
        else # 32 bit install
            root_url += "linux_386"
            sha = linux_386_sha256
        end
    end

    if sha == ""
        odie "Sorry, architecture not supported: See instructions on downloading Shipa Client from https://learn.shipa.io/docs/downloading-the-shipa-client"
    end

    sha256 sha
    url root_url
  
    def install
        bin.install Dir["shipa_*"] => "shipa"
    end
  
    test do
      system "#{bin}/shipa", "help"
    end
end