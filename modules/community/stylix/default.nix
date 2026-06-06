{ den, inputs, ... }:
{
  den.aspects.stylix.nixos =
    { lib, pkgs, ... }:
    {
      imports = [ inputs.stylix.nixosModules.stylix ];
      stylix = {
        enable = true;
        base16Scheme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/nord.yaml";
        targets = {
          # This breaks the console otherwise
          console.enable = false;
        };
        overlays.enable = false;
      };
    };
  den.aspects.stylixStandalone = {
    includes = with den.aspects; [ stylix ];
    nixos.stylix.homeManagerIntegration.autoImport = false;
  };
  den.aspects.stylix.homeManager = {
    imports = [ inputs.stylix.homeModules.stylix ];
    stylix.enable = true;
  };
  den.aspects.stylix.provides.root.homeManager.stylix.enable = false;
}
