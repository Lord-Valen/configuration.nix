{ den, ... }:
{
  den.aspects.rust = {
    provides.lord-valen.includes = [ den.aspects.rust ];
    includes = with den.aspects; [ development ];
    elcoco = {
      source = ./rust.el;
      extraPackages =
        epkgs: with epkgs; [
          rust-mode
        ];
    };
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        rustc
        cargo
        clippy
        rustfmt
      ];
    };
  };
}
