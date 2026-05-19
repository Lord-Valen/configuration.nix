{
  den.aspects.supercollider.homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        supercollider-with-sc3-plugins
        haskellPackages.tidal
      ];
    };
}
