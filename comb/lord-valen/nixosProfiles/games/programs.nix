{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
in {
  _imports = [inputs.aagl-gtk-on-nix.nixosModules.default];
  anime-game-launcher.enable = true;
  steam = {
    enable = true;
    package = nixpkgs.steam.override {
      extraPkgs = pkgs:
        with pkgs; [
          keyutils
          libkrb5
        ];
    };
    remotePlay.openFirewall = true;
    gamescopeSession.enable = true;
  };
  gamescope.enable = true;
  gamemode.enable = true;
}
