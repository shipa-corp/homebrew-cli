class LappsCli < Formula
    desc "Lens Apps cloud command-line interface"
    homepage "https://apps.lenscloud.io//"
    license "Apache-2.0"
    version "1.8.2"

    platform = ""
    sha = ""
    root_url = "https://storage.googleapis.com/shipa-client/" + version + "/lapps_"

    darwin_amd64_sha256 = "8e1995c3453d63ed9c5dcba038fa2585210f016dcd26215bd5279d7d6b0aa92b"
    linux_amd64_sha256 = "afe617ceb3a0c9126379fba4ec34fbdbb1987732f4a966d5220132ab6463ae29"
    linux_386_sha256 = "1643f36ef756a0b139b7285a185f0a5593ce36aa5c3582f776c5da525b51398d"

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
        odie "Sorry, architecture not supported: See instructions on downloading Lens Apps Client from https://learn.lenscloud.io/docs/downloading-the-lensapps-client"
    end

    sha256 sha
    url root_url + platform
  
    def install
        Dir["*"].each do |binary|
            File.rename(binary, "lapps")
        end
        bin.install "lapps"
    end
  
    test do
      system "#{bin}/lapps", "help"
    end
end