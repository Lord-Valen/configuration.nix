{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;

  inherit (cell) homeProfiles packages;
in {
  _imports = [homeProfiles.terminal];
  packages = with nixpkgs; [
    wofi
    hyprpicker
    wl-clipboard
    libnotify
    swaylock-effects
    inputs.watershot.packages.default

    # waybar
    playerctl

    # user
    light
  ];
}
