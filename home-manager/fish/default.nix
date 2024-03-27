{pkgs, ...}: {
  programs.fish = {
    enable = true;
    loginShellInit = ''
      set -gx EDITOR nvim
    '';
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    shellAliases = {
      v = "nvim";
      ls = "${pkgs.eza}/bin/eza --icons";
      la = "${pkgs.eza}/bin/eza --icons -la";
      lt = "${pkgs.eza}/bin/eza --icons --tree";
      docker-start = "sudo systemctl start docker";
      kssh = "kitten ssh";
      cop = "gh copilot suggest -t shell";
      rebuild = "nix fmt && git add . && sudo nixos-rebuild switch --flake .";
      rebuildt = "rebuild --show-trace --option eval-cache false";
      rebuildc = "rebuild && git commit";
      mount-diskroot = "sudo mkdir /disk-root && sudo mount /dev/root_vg/root /disk-root";
      pystart = "source ~/dev/python-template/.venv/bin/activate.fish && cruft create ~/dev/python-template && deactivate";
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

  my.setup-stuff.fish-variables = {
    enable = true;
    command = ''
      ${pkgs.fish}/bin/fish -c 'tide configure --auto --style=Lean --prompt_colors="True color" --show_time=No --lean_prompt_height="One line" --prompt_spacing=Compact --icons="Few icons" --transient=No'
    '';
  };

  my.setup-stuff.python-template = {
    enable = true;
    command = "/usr/bin/env bash ${./setup-python-template.sh}";
  };
}
