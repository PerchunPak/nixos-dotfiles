{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.programs.zellij;
in
{
  options = {
    programs.zellij = {
      plugins = lib.mkOption {
        type = lib.types.listOf lib.types.package;
        default = [ ];
        example = lib.literalExpression ''
          with pkgs.zellijPlugins; [ ghost harpoon nvim-nav-plugin ]
        '';
        description = "List of Zellij plugins";
      };
    };
  };

  config = {
    programs.zellij = {
      package = pkgs.zellij.override {
        extraPackages = lib.concatLists (lib.map (x: x.runtimeDeps or [ ]) cfg.plugins);
      };

      settings = {
        plugins = lib.mkIf (cfg.plugins != [ ]) (
          lib.mergeAttrsList (
            lib.map (
              plugin:
              let
                pluginName = lib.removePrefix "zellij-" plugin.pname;
              in
              {
                ${pluginName}._props = {
                  location = "file:${plugin}";
                };
              }
            ) cfg.plugins
          )
        );
        load_plugins = lib.mkIf (cfg.plugins != [ ]) {
          _children = lib.map (x: { ${x.pname} = [ ]; }) cfg.plugins;
        };
      };
    };
  };
}
