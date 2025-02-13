{ ... }:
final: prev: {
  vimPlugins = prev.vimPlugins // {
    nvim-dbee = final.vimUtils.buildVimPlugin (
      let
        self = final.vimPlugins.nvim-dbee;
        dbee-go = final.buildGoModule {
          name = "nvim-dbee";
          src = "${self.src}/dbee";
          vendorHash = "sha256-U/3WZJ/+Bm0ghjeNUILsnlZnjIwk3ySaX3Rd4L9Z62A=";
          buildInputs = [
            final.arrow-cpp
            final.duckdb
          ];
        };
      in
      {
        dependencies = [ final.vimPlugins.nui-nvim ];

        # nvim-dbee looks for the go binary in paths returned bu M.dir() and M.bin() defined in lua/dbee/install/init.lua
        postPatch = ''
          substituteInPlace lua/dbee/install/init.lua \
            --replace-fail 'return vim.fn.stdpath("data") .. "/dbee/bin"' 'return "${dbee-go}/bin"'
        '';

        preFixup = ''
          mkdir $target/bin
          ln -s ${dbee-go}/bin/dbee $target/bin/dbee
        '';

        pname = "nvim-dbee";
        version = "2024-07-26";
        src = final.fetchFromGitHub {
          owner = "kndndrj";
          repo = "nvim-dbee";
          tag = "v0.1.9";
          sha256 = "10xplksglyd8af8q1cl2lxcpn52b766g87gva9fd3l66idxsds00";
        };
        meta.homepage = "https://github.com/kndndrj/nvim-dbee/";
      }
    );
  };
}
