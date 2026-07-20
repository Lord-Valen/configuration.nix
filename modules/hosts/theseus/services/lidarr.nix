{
  den.aspects.servarr.provides.theseus.nixos = {
    services.newt.blueprint.private-resources.lidarr = {
      name = "Lidarr";
      mode = "http";
      destination = "localhost";
      destination-port = 8686;
      full-domain = "lidarr.laughing-man.xyz";
      scheme = "http";
      ssl = false;
      enabled = true;
    };
  };
}
