{pkgs, ...}: {
  environment.systemPackages = with pkgs; [inkscape];
}
