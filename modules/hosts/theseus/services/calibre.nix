{
  den.aspects.servarr.provides.theseus.nixos = {
    services.newt.blueprint.private-resources.calibre = {
      name = "Calibre";
      mode = "http";
      destination = "localhost";
      destination-port = 8080;
      full-domain = "calibre.laughing-man.xyz";
      scheme = "http";
      ssl = false;
      enabled = true;
    };
  };
}
