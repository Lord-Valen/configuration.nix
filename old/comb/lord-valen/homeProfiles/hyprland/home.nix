{
  inputs,
  cell,
  pkgs,
}:
let
  inherit (cell) homeProfiles;
in
{
  _imports = [ homeProfiles.terminal ];
  packages = with pkgs; [
    hyprpicker
    wl-clipboard
    libnotify
    swaylock-effects
    watershot

    # waybar
    playerctl

    # user
    light
  ];
}
