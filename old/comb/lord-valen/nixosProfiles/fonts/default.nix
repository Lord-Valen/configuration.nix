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
      (iosevka-bin.override { variant = "Etoile"; })
      (iosevka-bin.override { variant = "Aile"; })
      (iosevka-bin.override { variant = "SS05"; })
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
