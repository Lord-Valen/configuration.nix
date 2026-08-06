{
  den.aspects.servarr.nixos =
    { config, ... }:
    {
      services.calibre-server = {
        inherit (config.services.readarr) user group;
        enable = true;
        libraries = [ "/data/media/books" ];
        auth = {
          enable = true;
          mode = "basic";
          userDb = "/data/calibre-users.sqlite";
        };
      };
    };
}
