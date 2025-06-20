{
  den.aspects.nushell = {
    homeManager =
      { lib, ... }:
      let
        nuScripts =
          let
            inherit (lib.fileset) toList fileFilter;
            files = toList <| fileFilter ({ type, hasExt, ... }: type == "regular" && hasExt "nu") ./.;
          in
          files
          |> map (
            file:
            let
              inherit (lib.path) removePrefix;
              baseName = file |> removePrefix ./. |> lib.removeSuffix ".nu";
            in
            {
              name = ".local/bin/${baseName}";
              value = {
                source = file;
                executable = true;
              };
            }
          )
          |> lib.listToAttrs;
      in
      {
        home.file = nuScripts;
      };
  };
}
