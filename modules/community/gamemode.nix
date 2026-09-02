{
  den.aspects.gamemode = {
    nixos = {
      programs.gamemode.enable = true;
      nixpkgs.overlays = [
        (final: prev: {
          heroic = prev.heroic.override {
            extraPkgs =
              pkgs': with pkgs'; [
                gamemode
              ];
          };
          lutris = prev.lutris.override {
            extraPkgs =
              pkgs': with pkgs'; [
                gamemode
              ];
          };
        })
      ];
    };
  };
}
