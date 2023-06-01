class LappsCloudCli < Formula
    desc "Lens Apps cloud command-line interface"
    homepage "https://apps.lenscloud.io//"
    license "Apache-2.0"
    version "1.8.1-cloud"

    platform = ""
    sha = ""
    root_url = "https://storage.googleapis.com/shipa-client-cloud/" + version + "/lapps_"

    darwin_amd64_sha256 = "86eefb7270996618ac163da1098e47a50f16763125a11521ab77e5f96ef8bc56"
    linux_amd64_sha256 = "abba62ccf535f024e6876c324c4bea09f883946ee49644b512cbc4ca0d99024f"
    linux_386_sha256 = "9424a1b91c5c6abe1d8f511f5112c2833668f25bdca30f0ff2d807d75becabfc"

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