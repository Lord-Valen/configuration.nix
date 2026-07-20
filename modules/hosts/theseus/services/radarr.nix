{
  den.aspects.servarr.provides.theseus.nixos = {
    services.newt.blueprint.private-resources.radarr = {
      name = "Radarr";
      mode = "http";
      destination = "localhost";
      destination-port = 7878;
      full-domain = "radarr.laughing-man.xyz";
      scheme = "http";
      ssl = false;
      enabled = true;
    };
  };
}
