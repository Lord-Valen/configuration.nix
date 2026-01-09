{ config, ... }:
let
  inherit (config.flake) modules;
in
{
  flake.modules.nixos.steam =
    { pkgs, ... }:
    {
      imports = with modules.nixos; [
        gamemode
        gamescope
        avahi
      ];
      programs.steam = {
        enable = true;
        extraPackages = with pkgs; [
          wineasio
          pkgsi686Linux.pipewire.jack
        ];
        extraCompatPackages = with pkgs; [ proton-ge-bin ];
        remotePlay.openFirewall = true;
        gamescopeSession.enable = true;
        protontricks.enable = true;
      };
      hardware.steam-hardware.enable = true;
    };
}
