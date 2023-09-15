{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
in {
  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    enableDefaultPackages = true;
    packages = with nixpkgs; [
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
