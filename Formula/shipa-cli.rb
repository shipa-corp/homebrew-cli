class ShipaCli < Formula
    desc "Shipa command-line interface"
    homepage "https://shipa.io/"
    license "Apache-2.0"
    version "1.7.9"

    platform = ""
    sha = ""
    root_url = "https://storage.googleapis.com/shipa-client/" + version + "/shipa_"

    darwin_amd64_sha256 = "375a98e787fe96b7da6f9507187e12fee658fb58731b5447b555540a276411cb"
    linux_amd64_sha256 = "89f2aa64fb4123bc5749e5e765578d3db6e84a8ed91e1409d42efcdc51b26867"
    linux_386_sha256 = "0e83b8f3fdf6e0111def800d35c7c246146ccbbd7de9922cf566b033cb2f3ffd"

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