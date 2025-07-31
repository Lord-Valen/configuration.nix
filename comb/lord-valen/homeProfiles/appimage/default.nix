{
  inputs,
  cell,
  pkgs,
  config,
}:
let
  inherit (inputs.home-manager.lib) hm;
in
{
  home =
    let
      dir = config.home.homeDirectory + "/Applications";
    in
    {
      activation.createApplicationDirectory = hm.dag.entryAfter [ "writeBoundary" ] ''
        [[ -L "${dir}" ]] || mkdir -p $VERBOSE_ARG "${dir}"
      '';
      sessionPath = [ dir ];
    };
}
