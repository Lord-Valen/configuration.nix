{
  inputs,
  cell,
  pkgs,
}:
{
  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    enableDefaultPackages = true;
    packages = with pkgs; [
      (iosevka-bin.override { variant = "sgr-iosevka-etoile"; })
      (iosevka-bin.override { variant = "sgr-iosevka-aile"; })
      (iosevka-bin.override { variant = "sgr-iosevka-ss05"; })
      noto-fonts-emoji
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "Iosevka Etoile" ];
        sansSerif = [ "Iosevka Aile" ];
        monospace = [ "Iosevka SS05" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
