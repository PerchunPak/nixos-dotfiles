{ pkgs, ... }:
{
  programs.nushell = {
    enable = true;

    extraConfig = builtins.readFile ./config.nu;
    extraEnv =
      # nu
      ''
        # NU_LIB_DIRS
        # -----------
        # Directories in this constant are searched by the
        # `use` and `source` commands.
        #
        # By default, the `scripts` subdirectory of the default configuration
        # directory is included:
        const NU_LIB_DIRS = [
            ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
            ($nu.data-dir | path join 'completions') # default home for nushell completions
        ]
        # You can replace (override) or append to this list by shadowing the constant
        const NU_LIB_DIRS = $NU_LIB_DIRS ++ [($nu.data-dir | path join 'nu_scripts')]

        # # An environment variable version of this also exists. It is searched after the constant.
        # $env.NU_LIB_DIRS ++= [ ($nu.data-dir | path join "nu_scripts") ]

        # NU_PLUGIN_DIRS
        # --------------
        # Directories to search for plugin binaries when calling add.

        # By default, the `plugins` subdirectory of the default configuration
        # directory is included:
        const NU_PLUGIN_DIRS = [
            # ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
        ]
        # You can replace (override) or append to this list by shadowing the constant
        # const NU_PLUGIN_DIRS = $NU_PLUGIN_DIRS ++ [($nu.default-config-dir | path join 'plugins')]

        # As with NU_LIB_DIRS, an $env.NU_PLUGIN_DIRS is searched after the constant version
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
      shell = "nix-shell --run 'fish' -p";
      mtr = "mtr --order 'LSD   NBAW'";
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

      rollback =
        (pkgs.writeShellScript "rollback.sh" ''
          set -ex
          sudo nix-env --switch-generation "$1" -p /nix/var/nix/profiles/system
          sudo /nix/var/nix/profiles/system/bin/switch-to-configuration switch
        '').outPath;
    };
  };

  home.file.".local/share/nushell/nu_scripts".source = "${pkgs.nu_scripts}/share";
}
