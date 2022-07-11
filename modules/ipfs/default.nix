{ config, lib, pkgs, ... }:

with lib;

let cfg = config.modules.ipfs;
in {
  options.modules.ipfs = { enable = mkEnableOption "IPFS module"; };

  config = mkIf cfg.enable {
    services.ipfs = {
      enable = true;
      enableGC = true;
      extraConfig.Gateway.PublicGateways = null;
    };
  };
}
