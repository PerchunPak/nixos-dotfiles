{
  astal,
  libcava,
  fftw,
}:
astal.buildAstalModule {
  name = "cava";
  buildInputs = [
    libcava
    fftw
  ];
  meta.description = "Astal module for audio visualization using cava";
}
