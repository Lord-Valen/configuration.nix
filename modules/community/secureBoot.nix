{
  flake.aspects.secureBoot.nixos = {
    boot.loader.limine = {
      enable = true;
      secureBoot.enable = true;
    };
  };
}
