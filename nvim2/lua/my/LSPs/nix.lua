require('lze').load {
  'nixd',
  lsp = {
    filetypes = { 'nix' },
    settings = {
      nixd = {
        nixpkgs = {
          -- in the extras set of your package definition:
          -- nixdExtras.nixpkgs = ''import ${pkgs.path} {}''
          expr = nixCats.extra 'nixdExtras.nixpkgs',
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
