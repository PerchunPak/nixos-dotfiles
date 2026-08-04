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
    statusline_prefix="$(printf '%s' "$input" | "${pkgs.jq}/bin/jq" -r '
      def compact_home:
        . as $path
        | (env.HOME // "") as $home
        | if $path == "" then "?"
          elif $home != "" and $path == $home then "~"
          elif $home != "" and ($path | startswith($home + "/")) then "~" + ($path | ltrimstr($home))
          else $path
          end;

      (.model.display_name // .model.id // "unknown model" | tostring) as $model
      | (
          .effort.level?
          // .effortLevel?
          // .effort_level?
          // (if (.effort? | type) == "string" then .effort else "default" end)
          | tostring
        ) as $effort
      | ((.workspace.current_dir // .cwd // "") | tostring | compact_home) as $cwd
      | (
          .context_window.remaining_percentage
          // (if (.context_window.used_percentage? | type) == "number"
              then 100 - .context_window.used_percentage
              else null
              end)
        ) as $remaining
      | "\($model) \($effort) · \($cwd) · Context \(
          if ($remaining | type) == "number"
          then ($remaining | round | tostring)
          else "100"
          end
        )% left · "
    ' 2>/dev/null)"
    statusline_prefix="''${statusline_prefix:-unknown model default · ? · Context ?% left · }"
    transcript_path="$(printf '%s' "$input" | "${pkgs.jq}/bin/jq" -r '.transcript_path // empty')"

    if [ -n "$transcript_path" ] && [ -f "$transcript_path" ]; then
      totals="$("${pkgs.jq}/bin/jq" -rs '
        [ .[] | select(.type == "assistant" and (.message.usage? != null)) | .message.usage ]
        | {
            input: (map(.input_tokens // 0) | add // 0),
            output: (map(.output_tokens // 0) | add // 0)
          }
        | "in \(.input | tostring | gsub("(?<=\\d)(?=(\\d{3})+$)"; " ")) · out \(.output | tostring | gsub("(?<=\\d)(?=(\\d{3})+$)"; " "))"
      ' "$transcript_path")"
    else
      totals='in 0 · out 0'
    fi

    printf '%s%s\n' "$statusline_prefix" "$totals"
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
