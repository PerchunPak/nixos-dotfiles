{pkgs, ...}: {
  programs.fish = {
    enable = true;
    loginShellInit = ''
      set -gx EDITOR nvim
    '';
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      tide configure --auto --style=Lean --prompt_colors="True color" --show_time=No --lean_prompt_height="One line" --prompt_spacing=Compact --icons="Few icons" --transient=No
    '';
    shellAliases = {
      ls = "${pkgs.eza}/bin/eza --icons";
      la = "${pkgs.eza}/bin/eza --icons -la";
      lt = "${pkgs.eza}/bin/eza --icons --tree";
      docker-start = "sudo systemctl start docker";
      kssh = "kitten ssh";
      cop = "gh copilot suggest -t shell";
      rebuild = "nix fmt && git add . && sudo nixos-rebuild switch --flake .";
      rebuildt = "rebuild --show-trace --option eval-cache false";
      rebuildc = "rebuild && git commit";
    };
    plugins = [
      {
        name = "done";
        src = pkgs.fishPlugins.done.src;
      }
      {
        name = "z";
        src = pkgs.fishPlugins.z.src;
      }
      {
        name = "tide";
        src = pkgs.fishPlugins.tide.src;
      }
    ];
  };
}
