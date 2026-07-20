{
  den.aspects.servarr.provides.theseus.nixos = {
    services.newt.blueprint.public-resources.navidrome = {
      name = "Navidrome";
      protocol = "http";
      full-domain = "navidrome.laughing-man.xyz";
      enabled = true;
      targets = [
        {
          hostname = "localhost";
          port = 4533;
          method = "http";
        }
      ];
    };
  };
}
