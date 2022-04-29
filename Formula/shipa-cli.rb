class ShipaCli < Formula
    desc "Shipa command-line interface"
    homepage "https://shipa.io/"
    license "Apache-2.0"
    version "1.7.6"

    platform = ""
    sha = ""
    root_url = "https://storage.googleapis.com/shipa-client/" + version + "/shipa_"

    darwin_amd64_sha256 = "c846df3a4733b72b7e0e182ed541bc4310a495bc5d9e16a500c1005ce1213523"
    linux_amd64_sha256 = "92bea029796fe88ee21e6382371915439d81219fc055af63b677c50d89e5dcd9"
    linux_386_sha256 = "7d30b12ac23e96365317ab8f7a6bced46f9340f8d07b42d87ea7eef4ec4dae97"

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