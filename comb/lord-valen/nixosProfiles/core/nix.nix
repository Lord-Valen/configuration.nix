{ inputs, cell }:
let
  inherit (inputs)
    self
    nixpkgs'
    nixpkgs-stable
    nixpkgs-unstable
    ;
in
{
  gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 2d";
  };

  settings = {
    sandbox = true;

    trusted-users = [
      "root"
      "@wheel"
    ];
    allowed-users = [ "@wheel" ];

    auto-optimise-store = true;
  };

  extraOptions = ''
    experimental-features = nix-command flakes
    min-free = 1073741824 # preserve 1 GiB
    keep-outputs = true
    keep-derivations = true
    fallback = true
  '';

  nixPath = [
    "nixpkgs=${nixpkgs'.outPath}"
    "nixos-config=${self}"
  ];

  registry =
    let
      me = repo: {
        inherit repo;
        owner = "Lord-Valen";
        type = "github";
      };
    in
    rec {
      nixpkgs.flake = nixpkgs';
      stable.flake = nixpkgs-stable;
      unstable.flake = nixpkgs-unstable;
      configuration.to = me "configuration.nix";
      templates.to = me "nix-templates";
      devshells.to = templates.to;
    };
}
