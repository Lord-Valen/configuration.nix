{ config, lib, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.onlyoffice-bin ];
}
