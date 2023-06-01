class LappsCloudCli < Formula
    desc "Lens Apps cloud command-line interface"
    homepage "https://apps.lenscloud.io//"
    license "Apache-2.0"
    version "1.8.1-cloud"

    platform = ""
    sha = ""
    root_url = "https://storage.googleapis.com/shipa-client-cloud/" + version + "/lapps_"

    darwin_amd64_sha256 = "cc95761b23702de486788b799e3804309f5a0a6ed41449cd8b9b0b533119ace2"
    linux_amd64_sha256 = "ec8b15d2bf85d2a22c79c6f2d92c01991f9f8ca285ad7203ce7a96a5c8f9f3b2"
    linux_386_sha256 = "ef465069992903058520416d725dd948d97ec51275afc64e2206445c3651be62"

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
        odie "Sorry, architecture not supported: See instructions on downloading Shipa Client from https://learn.lenscloud.io/docs/downloading-the-lensapps-client"
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