{ inputs, ... }:
{
  flake.modules.nixos.appimage.programs.appimage = {
    enable = true;
    binfmt = true;
  };
  flake.modules.homeManager.appimage =
    { config, ... }:
    {
      home =
        let
          inherit (inputs.home-manager.lib) hm;
          dir = config.home.homeDirectory + "/Applications";
        in
        {
          activation.createApplicationDirectory = hm.dag.entryAfter [ "writeBoundary" ] ''
            [[ ! -d "${dir}" ]] && run mkdir -p "$VERBOSE_ARG" "${dir}"
          '';
          sessionPath = [ dir ];
        };
    };
}
