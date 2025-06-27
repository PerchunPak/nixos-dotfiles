{ pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellScriptBin "rebuild" ''
      set -ex
      trap 'cd -' EXIT

      cd ~/dotfiles
      git add .
      sudo true
      nh os switch "$@"
    '')

    (pkgs.writeShellScriptBin "nreview" ''
      set -ex

      trap 'cd -' EXIT
      cd ~/dev/nixpkgs/master
      ght nixpkgs-review pr --no-shell --systems "$@"
    '')

    (pkgs.writeShellScriptBin "modify" ''
      set -ex
      mv "$1" "$1"1
      cat "$1"1 > "$1"
    '')

    (pkgs.writeShellScriptBin "modify-undo" ''
      set -ex
      mv "$1" "$1".modified
      mv "$1"1 "$1"
    '')

    (pkgs.writeShellScriptBin "rollback" ''
      set -ex
      sudo nix-env --switch-generation "$1" -p /nix/var/nix/profiles/system
      sudo /nix/var/nix/profiles/system/bin/switch-to-configuration switch
    '')

    (pkgs.writeShellScriptBin "ght" ''
      set -e
      export GITHUB_TOKEN=$(rbw get 'GitHub CLI token')
      exec "$@"
    '')
  ];
}
