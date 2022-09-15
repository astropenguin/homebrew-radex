class Radex < Formula
  desc "Non-LTE molecular radiative transfer in homogeneous interstellar clouds"
  homepage "https://personal.sron.nl/~vdtak/radex/index.shtml"
  url "https://github.com/astropenguin/homebrew-radex/archive/v0.4.0.tar.gz"
  sha256 "dbda3dc4b23ba87a38b3669e1baebd88418a7b2b06ef1fc2cacbc933480519ea"

  depends_on "gcc" => :build

  def install
    ENV["DATADIR"] = ENV["HOMEBREW_DATADIR"]
    ENV["LOGFILE"] = ENV["HOMEBREW_LOGFILE"]
    ENV["MINITER"] = ENV["HOMEBREW_MINITER"]
    ENV["MAXITER"] = ENV["HOMEBREW_MAXITER"]
    system "make", "-e"
    bin.install "radex-uni"
    bin.install "radex-lvg"
    bin.install "radex-slab"
  end

  test do
    system "true"
  end
end
