{
  stdenv,
  nodejs,
  python3,
  lib,
  sources,
  ...
}:
stdenv.mkDerivation {
  pname = "ipfs-desktop";
  inherit (sources.ipfs-desktop) version src;
  buildInputs = [nodejs python3];
}
