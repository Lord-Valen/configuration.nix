{ inputs, cell }:
let
  inherit (inputs) self nixpkgs-stable nixpkgs-unstable;
in
{
  # NOTE: This is handled by nh. See ./programs.nix
  # gc = {
  #   automatic = true;
  #   dates = "weekly";
  #   options = "--delete-older-than 2d";
  # };

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

  nixPath = [ "nixos-config=${self}" ];

  registry =
    let
      me = repo: {
        inherit repo;
        owner = "Lord-Valen";
        type = "github";
      };
    in
    rec {
      stable.flake = nixpkgs-stable;
      unstable.flake = nixpkgs-unstable;
      configuration.to = me "configuration.nix";
      templates.to = me "nix-templates";
      devshells.to = templates.to;
    };
}
