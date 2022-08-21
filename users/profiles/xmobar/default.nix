{ config, lib, pkgs, ... }:

{
  xdg.configFile."xmobar".source = ./xmobar.d;
}
