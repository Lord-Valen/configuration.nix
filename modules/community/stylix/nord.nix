{
  flake.aspects.stylix-nord.nixos =
    { pkgs, ... }:
    {
      stylix = {
        base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
        cursor = {
          name = "graphite-nord";
          package = pkgs.graphite-cursors;
          size = 28;
        };
      };
    };
}
