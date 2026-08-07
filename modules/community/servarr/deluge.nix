{ den, ... }: {
  den.aspects.servarr = {
    includes = with den.aspects; [ deluge ];
    nixos = {
      services.deluge.web.enable = true;
    };
  };
}
