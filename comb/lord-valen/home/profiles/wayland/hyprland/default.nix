{
  pkgs,
  lib,
  ...
}: {
  imports = [../common.nix];
  home.packages = with pkgs; [
    kitty
    wofi
    waylock
    swww
    hyprpicker
    wl-clipboard
    libnotify
  ];

  services.mako.enable = true;

  xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
  xdg.configFile."hypr/monitor.conf".text = lib.mkDefault ''monitor=,preferred,auto,auto'';
  xdg.configFile."hypr/keyboard.conf".text = lib.mkDefault ''
    input {
      kb_layout = us
    }
  '';
}
