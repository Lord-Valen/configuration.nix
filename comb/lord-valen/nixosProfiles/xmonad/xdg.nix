{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
in {
  userDirs.enable = true;
  portal = {
    enable = true;
    extraPortals = with nixpkgs; [xdg-desktop-portal-kde];
    config = {
      xmonad.default = [
        "kde"
      ];
    };
  };
}
