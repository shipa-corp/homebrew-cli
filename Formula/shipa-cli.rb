class ShipaCli < Formula
    desc "Shipa command-line interface"
    homepage "https://shipa.io/"
    license "Apache-2.0"
    version "1.7.5"

    platform = ""
    sha = ""
    root_url = "https://storage.googleapis.com/shipa-client/" + version + "/shipa_"

    darwin_amd64_sha256 = "33bc041392436e503fb35627c367650b0615812b34f615b6d0c323337dc52190"
    linux_amd64_sha256 = "91e46edad1e0205fc0a105c8389129af8cec93b2f09988e6e6984b3eabf2f83b"
    linux_386_sha256 = "4282ee4b544da8a805fea1cc03c57e39cdeea42bb02970dbb456238988ad8088"

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