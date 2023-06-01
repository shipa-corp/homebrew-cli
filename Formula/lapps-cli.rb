class LappsCli < Formula
    desc "Lens Apps cloud command-line interface"
    homepage "https://apps.lenscloud.io//"
    license "Apache-2.0"
    version "1.8.1"

    platform = ""
    sha = ""
    root_url = "https://storage.googleapis.com/shipa-client/" + version + "/lapps_"

    darwin_amd64_sha256 = "3a3bdf42ef304e96cc11e28e46604ec5d62f5c6942b47c5c57e596eba6159d79"
    linux_amd64_sha256 = "457ccf361b7daebb2677df070d714fa379721946c060de98a062fc2d1f0398c8"
    linux_386_sha256 = "88209fa3404753635cc65b5a0fa783a833f4918a390a4955de1e762dcd98b967"

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