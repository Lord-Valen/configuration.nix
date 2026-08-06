{
  den.aspects.servarr.nixos = {
    services.deluge.enable = true;
    services.deluge.web.enable = true;

    networking.firewall = {
      allowedTCPPortRanges = [
        {
          from = 6881;
          to = 6889;
        }
      ];
      allowedUDPPortRanges = [
        {
          from = 6881;
          to = 6889;
        }
      ];
    };
  };
}
