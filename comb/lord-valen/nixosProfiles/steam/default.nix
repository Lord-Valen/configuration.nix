{
  inputs,
  cell,
  pkgs,
}:
{
  programs = {
    gamemode.enable = true;
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
