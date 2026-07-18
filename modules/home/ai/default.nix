{
  inputs,
  pkgs,
  ...
}:
let
  wrapper = inputs.wrappers.lib.evalModule ./claude-code.nix;
  claude-code = wrapper.config.wrap { inherit pkgs; };
in
{
  programs.codex.enable = true;
  programs.claude-code = {
    enable = true;
    package = claude-code;
  };

  home.packages = [ pkgs.t3code ];

  my.persistence = {
    directories = [
      ".cache/claude-cli-nodejs"
      ".claude"
      ".codex"
      ".t3"
    ];
    files = [ ".claude.json" ];
  };
}
