{
  inputs,
  cell,
}: {
  packages = with inputs.nixpkgs; [
    kitty
    wofi
    waylock
    wpaperd
    hyprpicker
    wl-clipboard
    libnotify

    # eww
    nushell
    socat
  ];
}
