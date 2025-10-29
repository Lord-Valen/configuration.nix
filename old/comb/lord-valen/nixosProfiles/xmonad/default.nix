{
  inputs,
  cell,
  pkgs,
}:
{
  environment.systemPackages = with pkgs; [
    xorg.xkill
    xmobar
    rofi
    kitty
    trayer
    flameshot
  ];

  fonts.packages = with pkgs; [
    fira-code
    font-awesome
  ];
}
