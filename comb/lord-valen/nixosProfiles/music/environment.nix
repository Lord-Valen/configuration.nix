{
  inputs,
  cell,
  pkgs,
}:
{
  systemPackages = with pkgs; [
    zrythm
    cardinal
    geonkick
    distrho-ports
    supercollider-with-sc3-plugins
    haskellPackages.tidal
    vcv-rack
    musescore
    guitarix
  ];
}
