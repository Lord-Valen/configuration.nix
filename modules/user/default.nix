{ config, lib, pkgs, ... }:

with lib;

let cfg = config.user;
in {
  options.user = mkOption {
    type = types.str;
    default = "lord-valen";
  };

  config = {
    users.users.${cfg} = {
      isNormalUser = true;
      createHome = true;
      extraGroups = [ "networkmanager" "wheel" ];
      initialPassword = "pass";
    };

    home-manager.users.${cfg}.home.stateVersion = "22.11";
  };
}
