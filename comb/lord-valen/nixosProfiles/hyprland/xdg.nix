{ inputs, cell }:
let
  inherit (inputs) nixpkgs;
in
{
  portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with nixpkgs; [ xdg-desktop-portal-hyprland ];
    config = {
      hyprland.default = [
        "hyprland"
        "wlr"
      ];
    };
  };
}
