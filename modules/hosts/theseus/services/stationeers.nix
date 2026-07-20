{
  den.aspects.stationeers.provides.theseus.nixos = {
    # Default 8443 collides with Gerbil's -sni-port.
    services.ssui.settings.SSUIPort = 8543;

    services.newt.blueprint = {
      # Admin panel - no reason to be internet-facing.
      private-resources.ssui = {
        name = "Stationeers Server UI";
        mode = "http";
        destination = "localhost";
        destination-port = 8543;
        full-domain = "ssui.laughing-man.xyz";
        scheme = "http";
        ssl = false;
        enabled = true;
      };

      # Raw game traffic - the whole reason this project exists, Cloudflare
      # can't proxy arbitrary UDP. Public, no VPN client needed to join.
      public-resources = {
        stationeers-update = {
          name = "Stationeers Update Port";
          protocol = "udp";
          proxy-port = 27015;
          enabled = true;
          targets = [
            {
              hostname = "localhost";
              port = 27015;
            }
          ];
        };

        stationeers-game = {
          name = "Stationeers Game Port";
          protocol = "udp";
          proxy-port = 27016;
          enabled = true;
          targets = [
            {
              hostname = "localhost";
              port = 27016;
            }
          ];
        };
      };
    };
  };
}
