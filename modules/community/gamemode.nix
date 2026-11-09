{
  den.aspects.gamemode = {
    nixpkgs-overlays = _: [
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
    nixos = {
      programs.gamemode.enable = true;
    };
  };
}
