{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  lib = nixpkgs.lib // builtins;
in {
  programs.eww.package = nixpkgs.eww-wayland;
  services.mako.enable = true;

  home.packages = with nixpkgs; [
    kitty
    wofi
    waylock
    flameshot
    wpaperd
    hyprpicker
    wl-clipboard
    libnotify
  ];

  xdg.configFile."hypr/hyprland.conf".source = ./_hyprland.conf;
  xdg.configFile."hypr/monitor.conf".text = lib.mkDefault ''monitor=,preferred,auto,auto'';
  xdg.configFile."hypr/keyboard.conf".text = lib.mkDefault ''
    input {
      kb_layout = us
    }
  '';
}
