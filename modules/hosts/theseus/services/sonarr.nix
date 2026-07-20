{
  den.aspects.servarr.provides.theseus.nixos = {
    services.newt.blueprint.private-resources.sonarr = {
      name = "Sonarr";
      mode = "http";
      destination = "localhost";
      destination-port = 8989;
      full-domain = "sonarr.laughing-man.xyz";
      scheme = "http";
      ssl = false;
      enabled = true;
    };
  };
}
