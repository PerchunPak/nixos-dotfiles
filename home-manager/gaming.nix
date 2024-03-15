{pkgs, ...}: {
  home.packages = with pkgs; [
    # TODO steam
    #protonup-qt # can I manage proton-GE from home-manager/nix?
    #protontricks
    prismlauncher # TODO impermanence
    xonotic # TODO impermanence?
  ];
}
