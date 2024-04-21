{
  lib,
  config,
  ...
}: let
  cfg = config.my.sleep;
in {
  options = {
    my.sleep = {
      disable = lib.mkEnableOption "disable sleep";
    };
  };

  config = lib.mkIf cfg.disable {
    systemd.sleep.extraConfig = ''
      AllowSuspend=no
      AllowHibernation=no
      AllowHybridSleep=no
      AllowSuspendThenHibernate=no
    '';
  };
}
