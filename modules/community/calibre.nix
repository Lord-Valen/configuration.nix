{
  flake.aspects.calibre.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [ calibre ];
    };
  flake.aspects.calibre.homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ calibre ];
    };
}
