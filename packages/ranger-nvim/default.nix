{pkgs, ...}:
pkgs.vimUtils.buildVimPlugin {
  pname = "ranger.nvim";
  version = "2024-02-09";
  src = pkgs.fetchFromGitHub {
    owner = "kelly-lin";
    repo = "ranger.nvim";
    rev = "d3b032feee6b3b0cf923222f260523e2bd7f3ad3";
    sha256 = "07c0rri7v0z9hjdj3vqsqjms43y2a9kqqac2s5is7ksz2hqi5yzj";
  };
  meta.homepage = "https://github.com/kelly-lin/ranger.nvim/";
}
