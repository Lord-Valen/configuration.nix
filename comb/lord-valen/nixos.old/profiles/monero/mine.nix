{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [./common.nix];
  services = {
    p2pool = {
      enable = true;
      address = "44JVCqQB9CvNn1HJcL9SfyBdGLbFk1dApXV1DWBrsoi7GJyfJaa6Vjbi2Y9SCM5wmBTMxbamAm3sjRpEJMMy4R9EPvYWHQe";
    };
  };
}
