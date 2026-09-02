{
  den.aspects.secureBoot.nixos = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [ sbctl ];
    boot.loader.limine = {
      enable = true;
      secureBoot.enable = true;
    };
  };
}
