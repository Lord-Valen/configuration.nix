{
  inputs,
  cell,
}: {
  packages = with inputs.nixpkgs; [
    kitty
    wofi
    waylock
    flameshot
    wpaperd
    hyprpicker
    wl-clipboard
    libnotify
  ];
}
