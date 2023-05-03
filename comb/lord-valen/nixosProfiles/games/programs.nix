{
  inputs,
  cell,
}: {
  _imports = [inputs.aagl-gtk-on-nix.nixosModules.default];
  an-anime-game-launcher.enable = true;
  steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };
  gamemode.enable = true;
}
