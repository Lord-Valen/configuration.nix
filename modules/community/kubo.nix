{
  flake.modules.nixos.kubo = {
    services.kubo = {
      enable = true;
      enableGC = true;
      settings = {
        Addresses.API = [ "/ip4/127.0.0.1/tcp/5001" ];
      };
    };
  };
  flake.modules.nixos.pc = {
    services.kubo.localDiscovery = true;
  };
}
