{ pkgs }:
{
  programs.gnome-shell = {
    enable = true;
    extensions =
      with pkgs.gnomeExtensions;
      map (package: { inherit package; }) [
        paperwm
        switcher
        system-monitor
        status-icons
        lilypad
      ];
  };
}
