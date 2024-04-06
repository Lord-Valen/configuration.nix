{
  inputs,
  cell,
  pkgs,
}:
{
  portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
    config = {
      hyprland.default = [
        "hyprland"
        "wlr"
      ];
    };
  };
}
