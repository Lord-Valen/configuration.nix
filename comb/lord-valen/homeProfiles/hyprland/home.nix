{ inputs, cell }:
let
  inherit (inputs) nixpkgs;

  inherit (cell) homeProfiles packages;
in
{
  _imports = [ homeProfiles.terminal ];
  packages = with nixpkgs; [
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
