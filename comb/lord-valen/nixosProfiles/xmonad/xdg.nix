{
  inputs,
  cell,
  pkgs,
}:
{
  userDirs.enable = true;
  portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-kde ];
    config = {
      xmonad.default = [ "kde" ];
    };
  };
}
