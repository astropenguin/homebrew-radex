class Radex < Formula
  desc "Non-LTE molecular radiative transfer in homogeneous interstellar clouds"
  homepage "https://personal.sron.nl/~vdtak/radex/index.shtml"
  url "https://github.com/astropenguin/homebrew-radex/archive/v0.5.0.tar.gz"
  sha256 "063d7e7c66510697bd2a1bc4b5711554f2dc187e4a33f77e97893b8bff762491"

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
