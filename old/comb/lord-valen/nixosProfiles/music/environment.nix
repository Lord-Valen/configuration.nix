{
  inputs,
  cell,
  pkgs,
}:
{
  # TODO: Break up into smaller profiles: writing/production/patching
  systemPackages = with pkgs; [
    zrythm
    cardinal
    geonkick
    distrho-ports
    supercollider-with-sc3-plugins
    haskellPackages.tidal
    vcv-rack
    musescore
    muse-sounds-manager
    guitarix
  ];
}
