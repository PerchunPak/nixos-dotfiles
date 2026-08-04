{ pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellScriptBin "rebuild" ''
      set -ex
      trap 'popd' EXIT

      pushd ~/dotfiles
      git add -A
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

    (pkgs.writeShellScriptBin "modifyu" ''
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

    (pkgs.writeShellScriptBin "kill-hypr" ''
      set -e

      pid=$(pgrep -u "$(id -u)" -f '^(.*/)?Hyprland([[:space:]]|$)' | head -n1)
      read -r signature wayland_display < <(
        hyprctl instances -j | jq -r --argjson pid "$pid" \
          '.[] | select(.pid == $pid) | [.instance, .wl_socket] | @tsv'
      )

      HYPRLAND_INSTANCE_SIGNATURE="$signature" WAYLAND_DISPLAY="$wayland_display" hyprshutdown
    '')
  ];
}
