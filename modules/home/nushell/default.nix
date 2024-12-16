{ pkgs, ... }:
let
  nu-scripts = "${pkgs.nu_scripts}/share/nu_scripts";
in
{
  programs.nushell = {
    enable = true;

    extraConfig = builtins.readFile ./config.nu;
    extraEnv =
      # nu
      ''
        source ${nu-scripts}/themes/nu-themes/catppuccin-mocha.nu
      '';

    shellAliases = {
      kssh = "kitten ssh";

      rebuild =
        (pkgs.writeShellScript "rebuild.sh" ''
          set -ex
          trap 'cd -' EXIT

          cd ~/dotfiles
          git add .
          sudo true
          nh os switch $@
        '').outPath;

      rebuildt = "rebuild -- --show-trace --option eval-cache false";
      mount-diskroot = "sudo mkdir /disk-root; sudo mount /dev/root_vg/root /disk-root";
      # pystart = "source ~/dev/python-template/.venv/bin/activate.fish; cruft create ~/dev/python-template; deactivate";
      shell = "nix-shell --run 'fish' -p";
      mtr = "mtr --order 'LSD   NBAW'";
      # gh = "GITHUB_TOKEN=$(rbw get 'GitHub CLI token') ${pkgs.gh}/bin/gh";
      # nixpkgs-review = "GITHUB_TOKEN=(rbw get 'GitHub CLI token') ${pkgs.nixpkgs-review}/bin/nixpkgs-review";
      nreview =
        (pkgs.writeShellScript "nreview.sh" ''
          set -e
          export GITHUB_TOKEN=$(rbw get 'GitHub CLI token')
          set -x

          trap 'cd -' EXIT
          cd ~/dev/nixpkgs/master
          nixpkgs-review $@
        '').outPath;

      modify =
        (pkgs.writeShellScript "modify.sh" ''
          set -ex
          mv "$1" "$1"1
          cat "$1"1 > "$1"
        '').outPath;
      modifyu =
        (pkgs.writeShellScript "modify-undo.sh" ''
          set -ex
          mv "$1" "$1".modified
          mv "$1"1 "$1"
        '').outPath;

      list-generations = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
      rollback =
        (pkgs.writeShellScript "rollback.sh" ''
          set -ex
          sudo nix-env --switch-generation "$1" -p /nix/var/nix/profiles/system
          sudo /nix/var/nix/profiles/system/bin/switch-to-configuration switch
        '').outPath;
    };
  };
}
