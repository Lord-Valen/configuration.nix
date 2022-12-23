channels: final: prev: {
  __dontExport = true; # overrides clutter up actual creations

  inherit
    (channels.nixpkgs-unstable)
    discord
    element-desktop
    signal-desktop
    onlyoffice-bin
    nil
    heroic
    ;

  haskellPackages = prev.haskellPackages.override (old: {
    overrides =
      prev.lib.composeExtensions (old.overrides or (_: _: {}))
      (hfinal: hprev: let
        version = prev.lib.replaceChars ["."] [""] prev.ghc.version;
      in {
        # same for haskell packages, matching ghc versions
        inherit
          (channels.nixpkgs-unstable.haskell.packages."ghc${version}")
          haskell-language-server
          ;
      });
  });
}
