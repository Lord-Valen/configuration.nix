{
  flake.modules.homeManager.discord =
    { pkgs, ... }:
    {
      # TODO: Use nixcord to install dorion.
      home.packages = with pkgs; [ dorion ];
    };
}
