class Radex < Formula
  desc "Non-LTE molecular radiative transfer in homogeneous interstellar clouds"
  homepage "https://personal.sron.nl/~vdtak/radex/index.shtml"
  url "https://github.com/astropenguin/homebrew-radex/archive/v0.6.0.tar.gz"
  sha256 "ce387963a561292b41865fbf4b89b7d5d343c993691640c64cfe52dc2f01807b"

  depends_on "gcc@12" => :build

  def install
    build_option_names = [
      "RADEX_DATADIR",
      "RADEX_LOGFILE",
      "RADEX_MINITER",
      "RADEX_MAXITER",
    ]

    args = []

    for name in build_option_names do
      if value = ENV["HOMEBREW_#{name}"]
        args << "#{name}=#{value}"
      end
    end

    system "make", "build", "FC=gfortran-12", *args

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
