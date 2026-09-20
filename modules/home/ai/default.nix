{
  config,
  inputs,
  lib,
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
            input: (map(
                (.input_tokens // 0)
                + (.cache_creation_input_tokens // 0)
              ) | add // 0),
            output: (map(.output_tokens // 0) | add // 0)
          }
        | "in \(.input | tostring | gsub("(?<=\\d)(?=(\\d{3})+$)"; " ")) · out \(.output | tostring | gsub("(?<=\\d)(?=(\\d{3})+$)"; " "))"
      ' "$transcript_path")"
    else
      totals='in 0 · out 0'
    fi

    printf '%s%s\n' "$statusline_prefix" "$totals"
  '';

  pstack = pkgs.fetchFromGitHub {
    owner = "michael-denyer";
    repo = "pstack-claude";
    rev = "c2ade4bba14fb4706857286afb5528bc2244bf44";
    hash = "sha256-e8I3TTf6JDHVc9FR+mz4AgKweEKqX8nJQ2b3uqz08Xw=";
  };
  mattpocock = pkgs.fetchFromGitHub {
    owner = "mattpocock";
    repo = "skills";
    rev = "6654f6b60cd9d5be8b54c6fafe44346dabeb3b76";
    hash = "sha256-N5tpUIHO2VFeJntBTl6/VLDIVpqoshwFxNJlfXXUwsQ=";
  };

  resetAiConfigs = pkgs.writeShellApplication {
    name = "reset-ai-configs";
    text = ''
      reset_config() {
        local source="$1"
        local target="$2"
        local temporary

        mkdir -p "$(dirname "$target")"
        temporary="$(mktemp "$(dirname "$target")/.config-reset.XXXXXX")"
        install -m 0600 "$source" "$temporary"
        mv -f "$temporary" "$target"
      }

      reset_config \
        ${lib.escapeShellArg config.home.file.".codex/config.toml".source} \
        ${lib.escapeShellArg "${config.home.homeDirectory}/.codex/config.toml"}
      reset_config \
        ${
          lib.escapeShellArg config.home.file."${config.home.homeDirectory}/.claude/settings.json".source
        } \
        ${lib.escapeShellArg "${config.home.homeDirectory}/.claude/settings.json"}
    '';
  };
in
{
  programs.codex = {
    enable = true;
    settings = {
      model = "gpt-5.6-sol";
      model_reasoning_effort = "medium";
      service_tier = "default";
      apps.connector_openai_hotline.enabled = false;
      tui = {
        status_line = [
          "model-with-reasoning"
          "current-dir"
          "context-remaining"
          "five-hour-limit"
          "weekly-limit"
          "total-input-tokens"
          "total-output-tokens"
          "task-progress"
        ];
        status_line_use_colors = true;
      };
      notice.hide_rate_limit_model_nudge = true;
    };
    context = ''
      If you need a command that is not installed, use `, command`. Example:
      $ glob **/*.py
      bash: glob: command not found
      $ , glob **/*.py
      <correct output>

      If user asked to commit changes, always add `Assisted-by: Model Name`.
      Example: `Assisted-by: GPT-5.6 Sol`, never use `Co-Authored-By:`.

      If user asks for an HTML report, always use dark scheme.

      If prompt is a question, answer it. Do not decide to do action unless
      user explicitly asks to.

      ---

      ${builtins.readFile ./unslop.md}
    '';
    skills = {
      writing-for-agents = "${mattpocock}/skills/productivity/writing-for-agents";
    };
  };

  programs.claude-code = {
    enable = true;
    package = claude-code;
    # gpt doesn't output thinking summaries without this
    context = ''
      Before major tool-call groups, provide one concise progress update. Between major phases, report what was completed and what comes next. Do not expose private chain-of-thought or narrate routine commands.
      Never spawn agents unless the user asks to.

      If you need a command that is not installed, use `, command`. Example:
      $ glob **/*.py
      bash: glob: command not found
      $ , glob **/*.py
      <correct output>

      If user asked to commit changes, always add `Assisted-by: Model Name`.
      Example: `Assisted-by: Claude Opus 5`, never use `Co-Authored-By:`.
      Do not use built-in commit tool, always invoke `git commit` manually.

      If user asks for an HTML report, always use dark scheme and create
      a local `.html` file. Never use Claude artifacts.

      If prompt is a question, answer it. Do not decide to do action unless
      user explicitly asks to.

      ---

      ${builtins.readFile ./unslop.md}
    '';
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
    skills = {
      writing-for-agents = "${mattpocock}/skills/productivity/writing-for-agents";
    };
  };

  home.packages = [ pkgs.t3code ];

  # Home Manager normally exposes generated settings as read-only store
  # symlinks. Replace those links with writable copies after activation, and
  # restore the declarative copies whenever the user manager starts.
  home.file = {
    ".codex/config.toml".force = true;
    "${config.home.homeDirectory}/.claude/settings.json".force = true;
  };

  home.activation.resetAiConfigs = inputs.home-manager.lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    run ${lib.getExe resetAiConfigs}
  '';

  systemd.user.services.reset-ai-configs = {
    Unit.Description = "Restore declarative Codex and Claude Code settings";
    Service = {
      Type = "oneshot";
      ExecStart = lib.getExe resetAiConfigs;
    };
    Install.WantedBy = [ "default.target" ];
  };

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
