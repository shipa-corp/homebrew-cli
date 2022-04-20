class ShipaCloudCli < Formula
    desc "Shipa cloud command-line interface"
    homepage "https://shipa.io/"
    license "Apache-2.0"
    version "1.7.3-cloud"

    platform = ""
    sha = ""
    root_url = "https://storage.googleapis.com/shipa-client-cloud/" + version + "/shipa_"

    darwin_amd64_sha256 = "65c5c5ab125e86beb97286136cf02bbadfa6acc23d1876ced9caa3c2a74b9a55"
    linux_amd64_sha256 = "d1fb0e3d2d4ba5934a778439f06777197195f4651484ca49d0bb2b461332e13c"
    linux_386_sha256 = "9fce48566c69d28cf71e7850c38478a22dbdb4e764d8d8655c5821fdda156fa1"

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