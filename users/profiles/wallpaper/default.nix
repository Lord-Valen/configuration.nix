{ config, lib, pkgs, ... }:

{
  xdg.configFile."wallpaper".source = ./wallpaper.d;
}
