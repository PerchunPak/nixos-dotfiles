{
  pkgs,
  config,
  ...
}: {
  programs.fish.plugins = [
    {
      name = "tide";
      src = pkgs.fishPlugins.tide.src;
    }
  ];

  xdg.configFile."fish/fish_variables.example".source = ./fish_variables.fish;

  # Copy fish_variables if not exists, tide saves there cache
  systemd.user.services."setup-fish-variables" = {
    Unit = {
      After = ["multi-user.target"];
      # 3 total retries
      StartLimitIntervalSec = 0;
      StartLimitBurst = 3;
    };

    Install.WantedBy = ["default.target"];
    Service = {
      Type = "oneshot";
      RestartSec = 5;
      Restart = "onfailure";
      ExecStart = ''
        ${pkgs.coreutils}/bin/cp -n ${config.xdg.configHome}/fish/fish_variables.example ${config.xdg.configHome}/fish/fish_variables
      '';
    };
  };
}
