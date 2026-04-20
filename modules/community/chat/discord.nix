{
  flake.modules.homeManager.discord =
    { ... }:
    {
      # TODO: Use nixcord to install dorion.
      # home.packages = with pkgs; [ dorion ];
    };
}
