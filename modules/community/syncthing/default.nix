{
  den.aspects.syncthing.nixos = args: {
    services.syncthing = {
      enable = true;
      group = "users";
      settings.devices = import ./_devices.nix args;
      openDefaultPorts = true;
    };
    networking.firewall = {
      # User Syncthing uses these ports
      allowedTCPPorts = [ 46693 ];
      allowedUDPPorts = [ 46693 ];
    };
  };
  den.aspects.syncthing.homeManager = args: {
    services.syncthing = {
      enable = true;
      guiAddress = "127.0.0.1:8385";
      settings.devices = import ./_devices.nix args;
      overrideFolders = false;
    };
  };
}
