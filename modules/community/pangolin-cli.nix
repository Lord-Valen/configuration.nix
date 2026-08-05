{ config, ... }: {
  den.aspects.pangolin-cli = {
    nixos = {
      nixpkgs.overlays = [ config.flake.overlays.fosrl-unstable ];
    };
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          pangolin-cli
        ];
      };
  };
}
