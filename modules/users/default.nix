{ config, lib, pkgs, ... }:

{
  users.users.lord-valen = {
    isNormalUser = true;
    createHome = true;
    extraGroups = [ "networkmanager" "wheel" ];
    initialPassword = "lv";
  };
}
