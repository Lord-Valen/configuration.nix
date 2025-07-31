{
  flake.modules.homeManager.tor =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        tor-browser-bundle-bin
      ];
    };
}
