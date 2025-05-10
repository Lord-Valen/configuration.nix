{ pkgs }:
{
  programs.gnome-shell = {
    enable = true;
    extensions =
      with pkgs.gnomeExtensions;
      map (package: { inherit package; }) [
        paperwm
      ];
  };
}
