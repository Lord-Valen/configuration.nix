{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
in {
  fonts = {
    fontDir.enable = true;
    enableDefaultFonts = true;
    enableGhostscriptFonts = true;
    fonts = with nixpkgs; [
      liberation_ttf
      fira
      fira-mono
      noto-fonts-emoji
    ];
    fontconfig = {
      defaultFonts = {
        serif = ["Liberation Serif"];
        sansSerif = ["Fira Sans"];
        monospace = ["Fira Mono"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
