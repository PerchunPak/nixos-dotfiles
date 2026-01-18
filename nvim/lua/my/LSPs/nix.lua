return {
  'nixd',
  lsp = {
    filetypes = { 'nix' },
    settings = {
      nixd = {
        nixpkgs = {
          expr = require 'nix-info' 'nixpkgs-path',
        },
        options = {
          nixos = {
            expr = '(builtins.getFlake "/home/perchun/dotfiles").nixosConfigurations.perchun-pc.options',
          },
        },
        formatting = {
          command = { 'nixfmt' },
        },
      },
    },
  },
}
