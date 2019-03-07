class FluidSynth < Formula
  desc "Real-time software synthesizer based on the SoundFont 2 specs"
  homepage "http://www.fluidsynth.org"
  url "https://github.com/FluidSynth/fluidsynth/archive/v2.0.4.tar.gz"
  sha256 "2c065de87e9c9ba0311ebf2f4828a4fd76f1f5cc7d1d93dd80d7a048d7d2a76c"
  head "https://github.com/FluidSynth/fluidsynth.git"

  bottle do
    cellar :any
    sha256 "a881760d1a2d37f01fb99c62e5760ca290b0a302ca14532e33422584cd6dd5b7" => :mojave
    sha256 "d15c30490cad51a60bc138fef78fc7e1339c6a070eb676f3eafd6ff70170ccb9" => :high_sierra
    sha256 "875610f52865d882a4531635dc2b39b5212f15f5a9d324410d3af227f0ffc5a8" => :sierra
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "glib"
  depends_on "libsndfile"
  depends_on "portaudio"

  def install
    args = std_cmake_args + %w[
      -Denable-framework=OFF
      -Denable-portaudio=ON
      -DLIB_SUFFIX=
      -Denable-dbus=OFF
      -Denable-sdl2=OFF
    ]

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
    end
  end

  test do
    assert_match /#{version}/, shell_output("#{bin}/fluidsynth --version")
  end
end
