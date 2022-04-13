class CloudCli < Formula
    desc "Shipa cloud command-line interface"
    homepage "https://shipa.io/"
    license "Apache-2.0"

    platform = ""
    sha = ""
    root_url = "https://storage.googleapis.com/shipa-client-cloud/1.7.1-cloud/shipa_"

    darwin_amd64_sha256 = "36164c63ce4288a63a4b0e24031d82b0d4761f8efb4700b88149f18f5626cdbf"
    linux_amd64_sha256 = "08b1034c70d8d11647a78991037691d1e0afc0c4ad53910ef1a004f701941645"
    linux_386_sha256 = "bef6507b6d0843f9d0b777fa47fb0c962190a19823bc5c842fbfaf8218e2618a"

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