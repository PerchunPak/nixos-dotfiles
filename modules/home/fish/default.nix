{ pkgs, ... }:
{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';

    shellAliases = {
      v = "nvim";
      ls = "${pkgs.eza}/bin/eza --icons --git";
      la = "ls -la";
      lt = "la --tree";
      kssh = "kitten ssh";
      cop = "gh copilot suggest -t shell";
      rebuild = "cd ~/dotfiles && git add . && sudo true && nh os switch";
      rebuildt = "rebuild -- --show-trace --option eval-cache false";
      mount-diskroot = "sudo mkdir /disk-root && sudo mount /dev/root_vg/root /disk-root";
      pystart = "source ~/dev/python-template/.venv/bin/activate.fish && cruft create ~/dev/python-template && deactivate";
      "." = "ranger";
      shell = "nix-shell --run 'fish' -p";
    };

    plugins = [
      {
        name = "done";
        src = pkgs.fishPlugins.done.src;
      }
      {
        name = "tide";
        src = pkgs.fishPlugins.tide.src;
      }
    ];
  };

  my = {
    persistence.directories = [ ".local/share/fish" ];
    setup-stuff.fish-prompt.command = ''
      ${pkgs.fish}/bin/fish -c 'tide configure --auto --style=Lean --prompt_colors="True color" --show_time=No --lean_prompt_height="One line" --prompt_spacing=Compact --icons="Few icons" --transient=No'
    '';
  };
}
