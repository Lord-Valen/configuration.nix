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
        openFirewall = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Whether to open the firewall for Stationeers Server UI.";
        };
        user = lib.mkOption {
          type = lib.types.str;
          default = "ssui";
          description = "User to run the Stationeers Server UI service as.";
        };
        group = lib.mkOption {
          type = lib.types.str;
          default = "ssui";
          description = "Group to run the Stationeers Server UI service as.";
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

        users.users.${cfg.user} = {
          isSystemUser = true;
          group = cfg.group;
          home = "/var/lib/ssui";
          createHome = true;
        };
        users.groups.${cfg.group} = { };

        systemd.services.ssui = {
          description = "Stationeers Server UI";

          after = [ "network.target" ];
          requires = [ "network-online.target" ];

          before = [ "multi-user.target" ];
          wantedBy = [ "multi-user.target" ];

          serviceConfig = {
            User = cfg.user;
            Group = cfg.group;
            StateDirectory = "ssui";
            WorkingDirectory = "/var/lib/ssui";
            ExecStartPre = ''
              ${lib.getExe' pkgs.coreutils "chown"} -R ${cfg.user}:${cfg.group} /var/lib/ssui
            '' + lib.optionalString (lib.isAttrs cfg.settings) ''
              ${lib.getExe' pkgs.coreutils "ln"} -sf ${settingsFile} /var/lib/ssui/UIMod/config/config.json
            '';
            ExecStart = "${lib.getExe cfg.package}";
            Restart = "on-failure";
          };
        };
      };
    };
}
