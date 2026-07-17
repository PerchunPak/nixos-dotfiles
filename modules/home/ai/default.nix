{ pkgs, ... }:
{
  programs.claude-code.enable = true;

  home.packages = [ pkgs.t3code ];

  home.sessionVariables = {
    ANTHROPIC_BASE_URL = "http://127.0.0.1:8317";
    ANTHROPIC_AUTH_TOKEN = "sk-DTQXH65d8GZS6NBWz";
    ANTHROPIC_DEFAULT_OPUS_MODEL = "gpt-5.6-sol (high)";
    ANTHROPIC_DEFAULT_SONNET_MODEL = "gpt-5.6-sol (medium)";
    ANTHROPIC_DEFAULT_HAIKU_MODEL = "gpt-5.6-terra (medium)";
  };

  my.persistence = {
    directories = [
      ".cache/claude-cli-nodejs"
      ".claude"
      ".t3"
    ];
    files = [ ".claude.json" ];
  };
}
