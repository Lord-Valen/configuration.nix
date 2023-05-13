{
  inputs,
  cell,
}: {
  packages = with inputs.nixpkgs; [
    kitty
    wofi
    wpaperd
    hyprpicker
    wl-clipboard
    libnotify
    swaylock-effects
    inputs.watershot.packages.default

    # eww
    nushell
    socat
  ];
}
