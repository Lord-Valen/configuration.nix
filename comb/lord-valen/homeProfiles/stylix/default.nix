{ inputs, pkgs }:
{
  imports = [ inputs.stylix.homeModules.stylix ];
  stylix = {
    enable = true;
    overlays.enable = false;

    /*
      NOTE: I'm not even using this, upstream should
      add an enable option or make it nullable. It also won't follow a symlink, so
      I'm forced to copy the file.

      Since it's here, might as well try it out.
    */
    image = ./_image.jpg;
    # The dark theme has much better contrast.
    polarity = "dark";

    # base16Scheme = {
    #   base00 = "0C0A20";
    #   base01 = "110D26";
    #   base02 = "1F1147";
    #   base03 = "546A90";
    #   base04 = "204052";
    #   base05 = "7984D1";
    #   base06 = "F2F3F7";
    #   base07 = "2D2844";
    #   base08 = "E61F44";
    #   base09 = "DF85FF";
    #   base0A = "FFD400";
    #   base0B = "7984D1";
    #   base0C = "1EA8FC";
    #   base0D = "42C6FF";
    #   base0E = "FF2AFC";
    #   base0F = "3F88AD";
    # };

    cursor = {
      name = "graphite-dark";
      package = pkgs.graphite-cursors;
      size = 28;
    };

    fonts = {
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
