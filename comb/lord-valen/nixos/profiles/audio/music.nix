{pkgs, ...}: {
  imports = [./common.nix];
  environment.systemPackages = [
    # DAW
    pkgs.zrythm
    pkgs.cardinal
    pkgs.geonkick
    pkgs.distrho

    # Tidal
    pkgs.supercollider-with-sc3-plugins
    pkgs.haskellPackages.tidal

    # VCV
    pkgs.vcv-rack
  ];
}
