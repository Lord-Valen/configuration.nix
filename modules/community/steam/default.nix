{ den, ... }:
{
  den.aspects.steam = {
    includes = with den.aspects; [
      gamemode
      gamescope
      avahi
    ];
    nixos =
      { pkgs, ... }:
      {
        programs.steam = {
          enable = true;
          extraCompatPackages = with pkgs; [ proton-ge-bin ];
          remotePlay.openFirewall = true;
          gamescopeSession.enable = true;
          protontricks.enable = true;
        };
        hardware.steam-hardware.enable = true;
      };
    provides.to-users.homeManager = { pkgs, ... }: {
      home.file.".local/share/Steam/compatibilitytools.d/Proton-GE".source =
        pkgs.proton-ge-bin.steamcompattool;

    };
  };
}
