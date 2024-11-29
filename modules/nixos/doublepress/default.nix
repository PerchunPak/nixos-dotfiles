{ pkgs, ... }:
{
  services.logind.powerKey = "ignore";

  services.acpid.handlers = {
    doublepress = {
      event = "button/power.*";
      action = # bash
        ''
          if [ "$1" !=  "button/power PBTN 00000080 00000000" ]; then
            exit 0
          fi

          echo "Powerbutton pressed"
          ${pkgs.my.doublepress}/bin/doublepress.sh &
        '';
    };
  };
}
