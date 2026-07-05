let
  sources = import ./nix/tamal { };
  wi = import sources.with-inputs;
  wrapSource = v: if builtins.isPath v || builtins.isString v then { outPath = v; } else v;
  wrappedSources = builtins.mapAttrs (_: wrapSource) sources;
  patchedSources = wrappedSources // {
    files = wrappedSources.files // { flake = false; };
  };
in
wi patchedSources
