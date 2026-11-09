{
  den.aspects.gamescope = {
    nixpkgs-overlays = _: [
      (final: prev: {
        heroic = prev.heroic.override {
          extraPkgs =
            pkgs': with pkgs'; [
              gamescope
            ];
        };
        lutris = prev.lutris.override {
          extraPkgs =
            pkgs': with pkgs'; [
              gamescope
            ];
        };
      })
    ];
    nixos =
      { pkgs, ... }:
      {
        programs.gamescope = {
          enable = true;
          # capSysNice = true;
        };
        environment.systemPackages = with pkgs; [
          gamescope-wsi # HDR
        ];
      };
  };
}
