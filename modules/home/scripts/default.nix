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

    (pkgs.writeShellScriptBin "ubuntu-interactive" ''
      set -eou pipefail

      build-docker-image() {
        tmpdir=$(mktemp -d)
        trap 'rm -rf "$tmpdir"' EXIT
        docker build --tag ubuntu-interactive --file "${./ubuntu-interactive.Dockerfile}" "$tmpdir"
      }

      if [[ -z "$(docker images -q ubuntu-interactive 2> /dev/null)" ]]; then
        build-docker-image
      else
        build_date=$(docker inspect -f '{{ .Created }}' ubuntu-interactive | head -c 10)
        echo "Last built the image on $build_date"
        seven_days_ago=$(date +%F -d '7 days ago')
        if [[ $build_date < $seven_days_ago ]]; then
          build-docker-image
        fi
      fi
      docker run --rm -it "$@" ubuntu-interactive
    '')
  ];
}
