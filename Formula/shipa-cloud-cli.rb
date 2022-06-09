class ShipaCloudCli < Formula
    desc "Shipa cloud command-line interface"
    homepage "https://shipa.io/"
    license "Apache-2.0"
    version "1.7.6-cloud"

    platform = ""
    sha = ""
    root_url = "https://storage.googleapis.com/shipa-client-cloud/" + version + "/shipa_"

    darwin_amd64_sha256 = "26ce4a127a6ae199cbedd504728b7fb27b61edf06a74945ef62dbf037b467596"
    linux_amd64_sha256 = "e8ddcec603c9d78e2a668dbf297e15897498bfa155054665be1e94cafcd0a73d"
    linux_386_sha256 = "71e397ca08ef16b79ae7476d69407e06322e82f9f2ffcbe191bf2bc8518a51ab"

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