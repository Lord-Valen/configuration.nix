{
  nix.settings = {
    substituters = ["https://cache.nixos.org/"];

    trusted-substituters = [
      # nix-community
      "https://nix-community.cachix.org"
      # aagl
      "https://ezkea.cachix.org"
      # hyprland
      "https://hyprland.cachix.org"
      # colmena
      "https://colmena.cachix.org"
    ];

    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "colmena.cachix.org-1:7BzpDnjjH8ki2CT3f6GdOk7QAzPOl+1t3LvTLXqYcSg="
    ];
  };
}
