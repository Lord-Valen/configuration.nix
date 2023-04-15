{pkgs, ...}: {
  home.packages = with pkgs; [kitty wofi waylock swww eww-wayland];

  xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
}
