{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
in {
  programs.hyprland.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = with nixpkgs; [xdg-desktop-portal-hyprland];
  };
}
