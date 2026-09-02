{ den, ... }: {
  den.aspects.heracles = {
    includes = with den.aspects; [
      secureBoot
    ];
    nixos = {
      boot.loader.efi.canTouchEfiVariables = true;
    };
  };
}
