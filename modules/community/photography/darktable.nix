{
  den.aspects.photography.provides.lord-valen = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [ darktable ];
      };
  };
}
