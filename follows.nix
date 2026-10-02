{
  nixpkgs-lib.follows = "nixpkgs";
  stylix = src: import src.outPath;
  mdnix = src: import src.outPath { };
  llm-agents.inputs.nixpkgs.follows = "nixpkgs-unstable";
  exos-wifi = src: import src.outPath;
}
