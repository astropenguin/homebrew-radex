class Radex < Formula
  desc "Non-LTE molecular radiative transfer in homogeneous interstellar clouds"
  homepage "https://sronpersonalpages.nl/~vdtak/radex/index.shtml"
  url "https://github.com/astropenguin/make-radex/archive/1.0.0.tar.gz"
  sha256 "6c50de94663ea1bb3b0b7cb4180d4e3b97a35b6b3bd6e128ac23f3f68f25a1d8"

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
