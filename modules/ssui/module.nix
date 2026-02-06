# SPDX-FileCopyrightText: 2026 Lord-Valen
#
# SPDX-License-Identifier: MIT

{
  flake.nixosModules.ssui =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      cfg = config.services.ssui;

      settingsFile = pkgs.writeText "config.json" (lib.toJSON cfg.settings);
    in
    {
      options.services.ssui = {
        enable = lib.mkEnableOption "Stationeers Server UI";
        package = lib.mkPackageOption pkgs "StationeersServerUI" {
          default = "ssui";
        };
        dataDir = lib.mkOption {
          type = lib.types.str;
          default = "/var/lib/ssui";
          description = "Main directory for Stationeers Server UI.";
        };
        openFirewall = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Whether to open the firewall for Stationeers Server UI.";
        };
        settings = lib.mkOption {
          type = with lib.types; nullOr attrs;
          default = null;
          description = "Configuration for Stationeers Server UI.";
        };
      };

      config = lib.mkIf cfg.enable {
        networking.firewall.allowedTCPPorts = lib.mkIf cfg.openFirewall [ cfg.settings.SSUIPort or 8443 ];
        networking.firewall.allowedUDPPorts = lib.mkIf cfg.openFirewall [
          (cfg.settings.UpdatePort or 27015)
          (cfg.settings.GamePort or 27016)
        ];
        systemd.services.ssui = {
          description = "Stationeers Server UI";

          after = [ "network.target" ];
          requires = [ "network-online.target" ];

          before = [ "multi-user.target" ];
          wantedBy = [ "multi-user.target" ];

          serviceConfig = {
            DynamicUser = true;
            WorkingDirectory = cfg.dataDir;
            ExecStartPre = ''
              ${lib.getExe' pkgs.coreutils "mkdir"} -p ${cfg.dataDir}
            ''
            ++ lib.optionalString (lib.isAttrs cfg.settings) ''
              ${lib.getExe' pkgs.coreutils "ln"} -sf ${settingsFile} ${cfg.dataDir}/UIMod/config/config.json
            '';
            ExecStart = "${lib.getExe cfg.package}";
            Restart = "on-failure";
          };
        };
      };
    };
}
