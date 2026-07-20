{
  wlib,
  pkgs,
  ...
}:
{
  imports = [ wlib.modules.default ];

  config = {
    package = pkgs.claude-code;
    env = {
      ANTHROPIC_BASE_URL = "http://127.0.0.1:8317";
      ANTHROPIC_AUTH_TOKEN = "123";
      ANTHROPIC_DEFAULT_OPUS_MODEL = "gpt-5.6-sol";
      ANTHROPIC_DEFAULT_SONNET_MODEL = "gpt-5.6-terra";
      ANTHROPIC_DEFAULT_HAIKU_MODEL = "gpt-5.6-luna";
      CLAUDE_CODE_MAX_CONTEXT_TOKENS = "372000";
      CLAUDE_CODE_AUTO_COMPACT_WINDOW = "372000";

      CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC = "1";
      DISABLE_NON_ESSENTIAL_MODEL_CALLS = "1";
      DISABLE_TELEMETRY = "1";
      DISABLE_INSTALLATION_CHECKS = "1";
    };
  };
}
