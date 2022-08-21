final: prev: rec {
  # keep sources this first
  sources = prev.callPackage (import ./_sources/generated.nix) { };
  # then, call packages with `final.callPackage`
  protonup-ng = prev.callPackage ./protonup-ng { source = sources.protonup-ng; };
}
