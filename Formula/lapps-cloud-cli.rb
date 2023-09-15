class LappsCloudCli < Formula
    desc "Lens Apps cloud command-line interface"
    homepage "https://apps.lenscloud.io//"
    license "Apache-2.0"
    version "1.8.3-cloud"

    platform = ""
    sha = ""
    root_url = "https://storage.googleapis.com/shipa-client-cloud/" + version + "/lapps_"

    darwin_amd64_sha256 = "65a23673bd14b313a41455a95f6799d3e23e2c74725d8e9f210622bc859b4b08"
    linux_amd64_sha256 = "81456025f38423507d9745c8e0f3510ed6d21c2216f6796dc23881e6ff4c0708"
    linux_386_sha256 = "8822b8f60b8e58d3667f2dbce3354f4420914a6cb7e809e7f14a90a52d3e9d37"

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