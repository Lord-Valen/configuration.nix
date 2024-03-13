{ inputs, cell }:
let
  inherit (inputs) nixpkgs;
in
{
  home.packages = with nixpkgs; [ vcv-rack ];

  home.file.".Rack2" = {
    source = ./_Rack2.d;
    recursive = true;
  };
}
