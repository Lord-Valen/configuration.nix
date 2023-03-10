{
  inputs,
  cell,
}: let
  inherit (cell) homeSuites;
  bee = {
    system = "x86_64-linux";
    home = inputs.home-manager;
    pkgs = inputs.nixpkgs.legacyPackages;
  };
  home = rec {
    username = "lord-valen";
    homeDirectory = "/home/${username}";
  };
  imports' = [
    inputs.nix-doom-emacs.hmModules
  ];
in {
  heracles = {
    inherit bee;
    home =
      home
      // {
        stateVersion = "22.05";
      };
    imports = with homeSuites;
    # profiles
      []
      # suites
      ++ base
      # modules
      ++ imports';
  };
}
