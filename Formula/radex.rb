class Radex < Formula
  desc "Non-LTE molecular radiative transfer in homogeneous interstellar clouds"
  homepage "https://personal.sron.nl/~vdtak/radex/index.shtml"
  url "https://github.com/astropenguin/homebrew-radex/archive/v0.5.2.tar.gz"
  sha256 "61fb09d52ca84be7026cf74a503c5473d98138ea9527d076ba4287fa2aa571b8"

  depends_on "gcc" => :build

  def install
    ENV["DATADIR"] = ENV["HOMEBREW_DATADIR"]
    ENV["LOGFILE"] = ENV["HOMEBREW_LOGFILE"]
    ENV["MINITER"] = ENV["HOMEBREW_MINITER"]
    ENV["MAXITER"] = ENV["HOMEBREW_MAXITER"]
    system "make", "-e", "build"
    bin.install "radex-1"
    bin.install "radex-2"
    bin.install "radex-3"
    bin.install "radex-uni"
    bin.install "radex-lvg"
    bin.install "radex-slab"
  end

  test do
    system "true"
  end
end
