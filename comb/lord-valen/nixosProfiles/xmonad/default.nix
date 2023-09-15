{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
in {
  environment.systemPackages = with nixpkgs; [
    xorg.xkill
    xmobar
    rofi
    kitty
    trayer
    flameshot
  ];

  fonts.packages = with nixpkgs; [fira-code font-awesome];
}
