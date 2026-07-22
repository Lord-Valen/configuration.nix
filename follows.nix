{
  nixpkgs-lib.follows = "nixpkgs";
  stylix = src: import src.outPath;
  mdnix = src: import src.outPath { };
}
