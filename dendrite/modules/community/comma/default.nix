{ inputs, ... }:
{
  flake.modules.homeManager.comma = {
    imports = [ inputs.nix-index-database.hmModules.nix-index ];
    programs.nix-index-database = {
      comma.enable = true;
    };
  };
}
