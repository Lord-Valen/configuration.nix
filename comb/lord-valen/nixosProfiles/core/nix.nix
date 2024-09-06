{ inputs }:
let
  inherit (inputs) nixpkgs-stable nixpkgs-unstable;
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

    auto-optimise-store = true;
    experimental-features = [
      "nix-command"
      "flakes"
      "repl-flake"
    ];
    min-free = 1073741824;
    fallback = true;
  };

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
