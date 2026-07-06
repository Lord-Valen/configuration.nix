{
  den.aspects.protonmail.homeManager =
    { pkgs, ... }:
    {
      # Stop the daemon before launching the GUI: systemctl --user stop protonmail-bridge
      services.protonmail-bridge.enable = true;
      home.packages = [ pkgs.protonmail-bridge-gui ];
    };
}
