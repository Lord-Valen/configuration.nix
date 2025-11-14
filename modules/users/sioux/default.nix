{
  lib,
  config,
  self,
  ...
}:
let
  username = "sioux";
  inherit (config.flake) modules;
in
{
  flake.modules = {
    nixos.${username} =
      { pkgs, ... }:
      {
        users.users.${username} = {
          initialHashedPassword = "$y$j9T$1ttrJXMNjeH62Or9EOGfG/$pdm3JxpOroaC5BaqDN/79xKEvlUXW5fjBMGKPTFqeyA";
          isNormalUser = true;
          createHome = true;
          extraGroups = [
            "networkmanager"
            "wheel"
          ];
        };
        imports =
          lib.singleton
          <| self.lib.importManyForUser username [
            modules.homeManager.${username}
          ];
      };
    homeManager.${username} = {
      imports = with modules.homeManager; [ base ];
      home = {
        inherit username;
        homeDirectory = "/${username}";
        stateVersion = lib.mkDefault "24.11";
        sessionPath = [ "$HOME/.local/bin" ];
      };
    };
  };
}
