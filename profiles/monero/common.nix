{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ monero-gui ];

  services = { monero = { enable = true; }; };
}
