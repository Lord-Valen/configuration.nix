{
  flake.modules.nixos.syncthing = args: {
    services.syncthing = {
      enable = true;
      group = "users";
      settings.devices = import ./_devices.nix args;
    };
  };
  flake.modules.homeManager.syncthing = args: {
    services.syncthing = {
      enable = true;
      guiAddress = "127.0.0.1:8385";
      settings.devices = import ./_devices.nix args;
    };
  };
}
