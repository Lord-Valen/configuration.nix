{
  inputs,
  cell,
  pkgs,
}:
{
  # TODO: Figure out if Steam needs avahi
  imports = with cell.nixosProfiles; [
    gamemode
    gamescope
    avahi
  ];
  programs = {
    steam = {
      enable = true;
      package = pkgs.steam.override {
        extraPkgs =
          pkgs: with pkgs; [
            keyutils
            libkrb5
          ];
      };
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
      remotePlay.openFirewall = true;
      gamescopeSession.enable = true;
    };
  };
  hardware.steam-hardware.enable = true;
}
