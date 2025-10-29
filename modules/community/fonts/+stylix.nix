{
  flake.modules.nixos.stylix =
    { pkgs, ... }:
    {
      stylix.fonts = {
        sizes = {
          desktop = 10;
          terminal = 11;
          popups = 11;
        };
        serif = {
          package = pkgs.iosevka-bin.override { variant = "Aile"; };
          name = "Iosevka Aile";
        };
        sansSerif = {
          package = pkgs.iosevka-bin.override { variant = "Etoile"; };
          name = "Iosevka Etoile";
        };
        monospace = {
          package = pkgs.iosevka-bin.override { variant = "SS05"; };
          name = "Iosevka Term SS05";
        };
      };
    };
}
