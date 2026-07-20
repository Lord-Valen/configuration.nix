{
  den.aspects.servarr.provides.theseus.nixos = {
    services.newt.blueprint.private-resources.prowlarr = {
      name = "Prowlarr";
      mode = "http";
      destination = "localhost";
      destination-port = 9696;
      full-domain = "prowlarr.laughing-man.xyz";
      scheme = "http";
      ssl = false;
      enabled = true;
    };
  };
}
