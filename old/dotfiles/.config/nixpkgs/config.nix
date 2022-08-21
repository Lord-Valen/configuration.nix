{ pkgs, ... }:

{
  allowUnfree = true;
  packageOverrides = pkgs: {
    xmonad = pkgs.xmonad-with-packages.override {
      packages = hPkgs: with hPkgs; [ xmonad-contrib ];
    };
  };
}
