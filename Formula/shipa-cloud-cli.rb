class ShipaCloudCli < Formula
    desc "Shipa cloud command-line interface"
    homepage "https://shipa.io/"
    license "Apache-2.0"
    version "1.7.4-cloud"

    platform = ""
    sha = ""
    root_url = "https://storage.googleapis.com/shipa-client-cloud/" + version + "/shipa_"

    darwin_amd64_sha256 = "02ed7479eeb7c4e2a89350e4e26563f89b18e2d2f4326a156b47a7bae86d48ec"
    linux_amd64_sha256 = "fe92d9d1f57094d3a3f55ae9aef5886b6c1f7f729753454eded7b9f53fa5f24e"
    linux_386_sha256 = "276104a4c75b9916564763c31e40da40625f73169f3f3577a41a46a8ecda0b0c"

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