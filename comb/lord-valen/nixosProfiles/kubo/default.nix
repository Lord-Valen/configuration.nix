{
  services.kubo = {
    enable = true;
    enableGC = true;
    settings = {
      Addresses.API = ["ip4/127.0.0.1/tcp/5001"];
      Gateway.PublicGateways = null;
    };
  };
}
