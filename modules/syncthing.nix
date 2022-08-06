{ config, lib, pkgs, ... }:

with lib;

let cfg = config.modules.syncthing;
in {
  options.modules.syncthing = { enable = mkEnableOption "Syncthing module"; };
  config = mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      group = "users";
      devices."oracle" = {
        id = "2N6Y4QI-PFZSERX-ECZRCQ3-2WZTKLO-G5G25IP-AMBFAY5-MQ5DSKP-KT2QGAD";
      };
    };
  };
}
