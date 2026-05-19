{
  den.aspects.tor.homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        tor-browser
      ];
    };
}
