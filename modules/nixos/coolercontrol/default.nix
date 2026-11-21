{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.my.coolercontrol;
  # Only used for its option type. Its generator writes every table as a
  # [section], but the daemon requires some tables to be inline, e.g.
  # `fan1 = { speed_fixed = 0 }`, and fails with "Channel Setting should be
  # an inline table" otherwise.
  toml = pkgs.formats.toml { };

  isTable = builtins.isAttrs;
  isInline = t: !lib.any isTable (lib.attrValues t);
  isTableList = v: builtins.isList v && v != [ ] && lib.all isTable v;

  key = k: if builtins.match "[A-Za-z0-9_-]+" k != null then k else builtins.toJSON k;
  value =
    v:
    if isTable v then
      "{ ${lib.concatStringsSep ", " (lib.mapAttrsToList (k: v: "${key k} = ${value v}") v)} }"
    else if builtins.isList v then
      "[${lib.concatMapStringsSep ", " value v}]"
    else if builtins.isFloat v then
      let
        s = builtins.toJSON v;
      in
      if lib.hasInfix "." s || lib.hasInfix "e" s then s else "${s}.0"
    else
      builtins.toJSON v;

  section =
    path: t:
    let
      isSection = v: isTable v && (path == [ ] || !isInline v);
      values = lib.filterAttrs (_: v: !isSection v && !isTableList v) t;
      sections = lib.filterAttrs (_: isSection) t;
      tableLists = lib.filterAttrs (_: isTableList) t;
      name = k: lib.concatMapStringsSep "." key (path ++ [ k ]);
    in
    lib.concatStrings (
      lib.mapAttrsToList (k: v: "${key k} = ${value v}\n") values
      ++ lib.mapAttrsToList (k: v: "\n[${name k}]\n${section (path ++ [ k ]) v}") sections
      ++ lib.concatLists (
        lib.mapAttrsToList (k: map (v: "\n[[${name k}]]\n${section (path ++ [ k ]) v}")) tableLists
      )
    );

  render = name: t: pkgs.writeText name (section [ ] t);

  configFile = render "coolercontrol-config.toml" cfg.config;
  overridesFile = render "coolercontrol-overrides.toml" cfg.overrides;
in
{
  options = {
    my.coolercontrol = {
      enable = lib.mkEnableOption "CoolerControl";
      config = lib.mkOption {
        description = ''
          Contents of /etc/coolercontrol/config.toml. The daemon rewrites this
          file, so it is copied (not linked) on every start and GUI changes
          last only until the next restart.
        '';
        type = toml.type;
      };
      overrides = lib.mkOption {
        description = "Contents of /etc/coolercontrol/overrides.toml (device and channel names).";
        type = toml.type;
        default = { };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.coolercontrol.enable = true;

    systemd.services.coolercontrold = {
      restartTriggers = [
        configFile
        overridesFile
      ];
      preStart = ''
        install -Dm644 ${configFile} /etc/coolercontrol/config.toml
        install -Dm644 ${overridesFile} /etc/coolercontrol/overrides.toml
      '';
    };
  };
}
