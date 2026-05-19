{ ... }:
{
  den.aspects.appimage = {
    nixos.programs.appimage = {
      enable = true;
      binfmt = true;
    };

    provides.to-users.homeManager =
      { config, lib, ... }:
      {
        home =
          let
            dir = config.home.homeDirectory + "/AppImages";
          in
          {
            activation.createApplicationDirectory = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
              [[ ! -d "${dir}" ]] && run mkdir -p $VERBOSE_ARG "${dir}"
            '';
            sessionPath = [ dir ];
          };
      };
  };
}
