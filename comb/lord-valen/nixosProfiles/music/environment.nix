{ inputs, cell }:
{
  systemPackages = with inputs.nixpkgs; [
    zrythm
    cardinal
    geonkick
    distrho
    supercollider-with-sc3-plugins
    haskellPackages.tidal
    vcv-rack
  ];
}
