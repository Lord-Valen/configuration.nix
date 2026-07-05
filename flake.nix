{
  nixConfig = {
    extra-experimental-features = "nix-command flakes pipe-operators";
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    extra-trusted-substituters = [ "https://nix-community.cachix.org" ];
  };

  outputs = _: import ./. { };
}
