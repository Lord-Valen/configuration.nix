{ config, lib, pkgs, ... }:

{
  config = {
    users.users.lord-valen = {
      isNormalUser = true;
      createHome = true;
      extraGroups = [ "networkmanager" "wheel" ];
      initialPassword = "lv";
    };

    home-manager.users.lord-valen.home.stateVersion = "22.11";
  };
}
