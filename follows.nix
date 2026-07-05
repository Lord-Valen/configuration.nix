{
  nixpkgs-lib.follows = "nixpkgs";
  stylix = src: import src.outPath;
}
