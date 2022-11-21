final: prev: rec {
  # keep sources this first
  sources = prev.callPackage (import ./_sources/generated.nix) {};
  # then, call packages with `final.callPackage`
  ipfs-desktop = prev.callPackage ./ipfs-desktop {source = sources.ipfs-desktop;};
}
