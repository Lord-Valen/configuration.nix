{
  inputs,
  cell,
  pkgs,
}:
{
  _imports = [ inputs.aagl-gtk-on-nix.nixosModules.default ];
  anime-game-launcher.enable = true;
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
  gamescope.enable = true;
  gamemode.enable = true;
}
