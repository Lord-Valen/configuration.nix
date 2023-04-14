{pkgs, ...}: {
  home.packages = with pkgs; [
    wofi
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ./hyprland.conf;
  };
}
