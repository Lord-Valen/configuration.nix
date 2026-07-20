{
  den.aspects.servarr.provides.theseus.nixos = {
    services.newt.blueprint.private-resources.bazarr = {
      name = "Bazarr";
      mode = "http";
      destination = "localhost";
      destination-port = 6767;
      full-domain = "bazarr.laughing-man.xyz";
      scheme = "http";
      ssl = false;
      enabled = true;
    };
  };
}
