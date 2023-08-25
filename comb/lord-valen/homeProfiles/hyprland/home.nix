{
  inputs,
  cell,
}: {
  _imports = [cell.homeProfiles.terminal];
  packages = with inputs.nixpkgs; [
    wofi
    wpaperd
    hyprpicker
    wl-clipboard
    libnotify
    swaylock-effects
    inputs.watershot.packages.default

    # eww
    killall
    nushell
    socat
  ];
}
