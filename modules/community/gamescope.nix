{
  den.aspects.gamescope.nixos =
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
}
