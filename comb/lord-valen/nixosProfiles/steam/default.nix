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
      extraPackages = with pkgs; [
        wineasio
        pkgsi686Linux.pipewire.jack
      ];
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
      remotePlay.openFirewall = true;
      gamescopeSession.enable = true;
    };
  };
  hardware.steam-hardware.enable = true;
}
