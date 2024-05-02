{
  inputs,
  cell,
  pkgs,
}:
{
  services.xserver.desktopManager.retroarch = {
    enable = true;
    package = pkgs.retroarch.override {
      cores = with pkgs.libretro; [
        scummvm
        beetle-psx
        ppsspp
        pcsx2
        mgba
        mesen
        bsnes
        mupen64plus
        blastem
      ];
    };
  };
}
