{ inputs, ... }:
{
  flake.modules.homeManager.comma = {
    imports = [ inputs.nix-index-database.homeModules.nix-index ];
    programs.nix-index-database = {
      comma.enable = true;
    };
  };
}
