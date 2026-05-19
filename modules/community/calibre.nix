{
  den.aspects.calibre.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [ calibre ];
    };
  den.aspects.calibre.homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ calibre ];
    };
}
