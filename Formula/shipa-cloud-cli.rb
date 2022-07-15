class ShipaCloudCli < Formula
    desc "Shipa cloud command-line interface"
    homepage "https://shipa.io/"
    license "Apache-2.0"
    version "1.7.9-cloud"

    platform = ""
    sha = ""
    root_url = "https://storage.googleapis.com/shipa-client-cloud/" + version + "/shipa_"

    darwin_amd64_sha256 = "0adea448c59098289cdebd475c9417126ed279b62c24a652834ac19341bb59ae"
    linux_amd64_sha256 = "18d2554459a958583e8f3cd95ff3bfb0cac00c48c8672d7fb2f854bf2e439b2e"
    linux_386_sha256 = "302786abbdb0972cf053316cbab09fc1198f650c254085f544f6670ae8416eb5"

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