class ShipaCloudCli < Formula
    desc "Shipa cloud command-line interface"
    homepage "https://shipa.io/"
    license "Apache-2.0"
    version "1.20.6-cloud"

    platform = ""
    sha = ""
    root_url = "https://storage.googleapis.com/shipa-client-cloud/" + version + "/shipa_"

    darwin_amd64_sha256 = "6e6cc9951b22c2813894d0de86aa8d202971c5f12e99b890d0dfd16bcbf38bac"
    linux_amd64_sha256 = "0aca7dde0587136eae93e9b75042af9379f9654568b72318b0544529002564d2"
    linux_386_sha256 = "81646be9a168cc689d239a196c92c305517b76e480db6f2ff7fd7ee3af96e9f1"

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