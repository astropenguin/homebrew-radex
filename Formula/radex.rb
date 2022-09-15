class Radex < Formula
  desc "Non-LTE molecular radiative transfer in homogeneous interstellar clouds"
  homepage "https://personal.sron.nl/~vdtak/radex/index.shtml"
  url "https://github.com/astropenguin/homebrew-radex/archive/v0.3.1.tar.gz"
  sha256 "31059d53577cc076b3c399db67ac8e84f74c361bcfff42d359778ca80ef9069e"

  depends_on "gcc" => :build

  def install
    ENV["DATADIR"] = ENV["HOMEBREW_DATADIR"]
    ENV["LOGFILE"] = ENV["HOMEBREW_LOGFILE"]
    ENV["MINITER"] = ENV["HOMEBREW_MINITER"]
    ENV["MAXITER"] = ENV["HOMEBREW_MAXITER"]
    system "make", "-e", "build"
    bin.install "radex-uni"
    bin.install "radex-lvg"
    bin.install "radex-slab"
  end

  test do
    system "true"
  end
end
