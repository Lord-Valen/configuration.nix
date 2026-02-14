{ inputs, config, ... }:
{
  flake.aspects.stylix.nixos =
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
  flake.aspects.stylixStandalone.nixos = {
    imports = [ config.flake.modules.nixos.stylix ];
    stylix.homeManagerIntegration.autoImport = false;
  };
  flake.aspects.stylix.homeManager = {
    imports = [ inputs.stylix.homeModules.stylix ];
    stylix.enable = true;
  };
}
