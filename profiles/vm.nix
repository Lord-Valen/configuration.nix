{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ virt-manager ];
}
