{
  den.aspects.servarr.provides.theseus.nixos = {
    services.newt.blueprint.public-resources.jellyfin = {
      name = "Jellyfin";
      protocol = "http";
      full-domain = "jellyfin.laughing-man.xyz";
      enabled = true;
      targets = [
        {
          hostname = "localhost";
          port = 8096;
          method = "http";
        }
      ];
    };
  };
}
