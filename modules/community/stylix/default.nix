{ inputs, config, ... }:
{
  flake.modules.nixos.stylix =
    { pkgs, ... }:
    {
      imports = [ inputs.stylix.nixosModules.stylix ];
      stylix = {
        enable = true;
        cursor = {
          name = "graphite-dark";
          package = pkgs.graphite-cursors;
          size = 28;
        };
        targets = {
          # This breaks the console otherwise
          console.enable = false;
        };
        overlays.enable = false;
      };
    };
  flake.modules.nixos.stylixStandalone = {
    imports = [ config.flake.modules.nixos.stylix ];
    stylix.homeManagerIntegration.autoImport = false;
  };
  flake.modules.homeManager.stylix = {
    imports = [ inputs.stylix.homeModules.stylix ];
    stylix.enable = true;
  };
}
