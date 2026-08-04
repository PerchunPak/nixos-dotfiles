{
  inputs,
  pkgs,
  ...
}:
let
  wrapper = inputs.wrappers.lib.evalModule ./claude-code.nix;
  claude-code = wrapper.config.wrap { inherit pkgs; };

  statusline = pkgs.writeShellScript "claude-statusline" ''
    input="$("${pkgs.coreutils}/bin/cat")"
    transcript_path="$(printf '%s' "$input" | "${pkgs.jq}/bin/jq" -r '.transcript_path // empty')"

    if [ -n "$transcript_path" ] && [ -f "$transcript_path" ]; then
      "${pkgs.jq}/bin/jq" -rs '
        [ .[] | select(.type == "assistant" and (.message.usage? != null)) | .message.usage ]
        | {
            input: (map(.input_tokens // 0) | add // 0),
            output: (map(.output_tokens // 0) | add // 0)
          }
        | "in \(.input | tostring | gsub("(?<=\\d)(?=(\\d{3})+$)"; " ")) | out \(.output | tostring | gsub("(?<=\\d)(?=(\\d{3})+$)"; " "))"
      ' "$transcript_path"
    else
      printf 'in 0 | out 0\n'
    fi
  '';
in
{
  programs.codex.enable = true;
  programs.claude-code = {
    enable = true;
    package = claude-code;
    settings = {
      model = "opus";
      skipDangerousModePermissionPrompt = true;
      theme = "dark";
      effortLevel = "medium";
      statusLine = {
        type = "command";
        command = statusline;
      };
    };
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
