{
  wlib,
  pkgs,
  ...
}:
{
  imports = [ wlib.modules.default ];

  config = {
    package = pkgs.claude-code;
    envDefault = {
      CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC = "1";
      DISABLE_NON_ESSENTIAL_MODEL_CALLS = "1";
      DISABLE_TELEMETRY = "1";
      DISABLE_INSTALLATION_CHECKS = "1";
    };
    flags = {
      "--dangerously-skip-permissions" = true;
    };
  };
}
