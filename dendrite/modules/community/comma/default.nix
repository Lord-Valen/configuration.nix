{ inputs, ... }:
{
  flake.modules.home-manager.commaa = {
    imports = [ inputs.nix-index-database.hmModules.nix-index ];
    programs.nix-index-database = {
      comma.enable = true;
    };
  };
}
