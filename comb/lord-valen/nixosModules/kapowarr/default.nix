{
  cell,
  config,
  pkgs,
  lib,
}:
let
  cfg = config.services.kapowarr;
in
{
  meta.maintainers = with lib.maintainers; [ lord-valen ];

  options.services.kapowarr = {
    enable = lib.mkEnableOption;
    package = lib.mkPackageOption cell.packages "kapowarr" { };

    user =
      with lib;
      mkOption {
        type = types.str;
        default = "kapowarr";
        description = "The user account under which Kapowarr runs.";
      };
    group =
      with lib;
      mkOption {
        type = types.str;
        default = "kapowarr";
        description = "The group under which Kapowarr runs.";
      };

    dataDir =
      with lib;
      mkOption {
        type = types.path;
        default = "/var/lib/kapowarr/";
        description = "The directory where Kapowarr stores its data files.";
      };

    openFirewall = lib.mkEnableOption "Open ports in the firewall for Kapowarr.";
  };

  config = lib.mkIf cfg.enable {

    systemd.services.kapowarr = {
      description = "Kapowarr";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "simple";
        User = cfg.user;
        Group = cfg.group;
        ExecStart = "${lib.getExe cfg.package} --DatabaseFolder ${cfg.dataDir}";
      };

      networking.firewall = lib.mkIf cfg.openFirewall { allowedTCPPorts = [ 5656 ]; };
    };
  };
}
