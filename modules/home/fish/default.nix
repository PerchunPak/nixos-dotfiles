{ pkgs, ... }:
{
  programs.fish = {
    enable = true;

    interactiveShellInit = # fish
      ''
        set fish_greeting # Disable greeting
        fish_vi_key_bindings # Vim mode
        set PATH "./node_modules/.bin:$PATH"
      '';

    shellAliases = {
      ls = "${pkgs.eza}/bin/eza --icons --git";
      la = "ls -la";
      lt = "la --tree";
      kssh = "kitten ssh";
      rebuildt = "rebuild -- --show-trace --option eval-cache false";
      mount-diskroot = "sudo mkdir /disk-root && sudo mount /dev/root_vg/root /disk-root";
      pystart = "source ~/dev/python-template/.venv/bin/activate.fish && cruft create ~/dev/python-template && deactivate";
      shell = "nix-shell --run 'fish' -p";
      mtr = "mtr --order 'LSD   NBAW'";
      gh = "GITHUB_TOKEN=(rbw get 'GitHub CLI token') ${pkgs.gh}/bin/gh";
      nixpkgs-review = "GITHUB_TOKEN=(rbw get 'GitHub CLI token') ${pkgs.nixpkgs-review}/bin/nixpkgs-review";
      list-generations = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
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
