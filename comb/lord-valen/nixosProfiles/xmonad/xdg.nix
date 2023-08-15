{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
in {
  portal = {
    enable = true;
    extraPortals = with nixpkgs; [xdg-desktop-portal-kde];
  };
}
