{
  inputs,
  cell,
}: {
  gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  settings = {
    sandbox = true;

    trusted-users = ["root" "@wheel"];
    allowed-users = ["@wheel"];

    auto-optimise-store = true;
  };

  extraOptions = ''
    experimental-features = nix-command flakes
    min-free = 536870912
    keep-outputs = true
    keep-derivations = true
    fallback = true
  '';

  registry = let
    me = repo: {
      inherit repo;
      owner = "Lord-Valen";
      type = "github";
    };
  in rec {
    stable.flake = inputs.nixpkgs-stable;
    unstable.flake = inputs.nixpkgs-unstable;
    configuration.to = me "configuration.nix";
    templates.to = me "nix-templates";
    devshells.to = templates.to;
  };
}
