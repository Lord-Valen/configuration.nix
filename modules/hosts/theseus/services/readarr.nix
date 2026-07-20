{
  den.aspects.servarr.provides.theseus.nixos = {
    services.newt.blueprint.private-resources.readarr = {
      name = "Readarr";
      mode = "http";
      destination = "localhost";
      destination-port = 8787;
      full-domain = "readarr.laughing-man.xyz";
      scheme = "http";
      ssl = false;
      enabled = true;
    };
  };
}
