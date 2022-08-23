{ config, lib, pkgs, ... }:

{
  nixpkgs.config = {
    # I want to keep proprietary software to a minimum.
    # allowUnfreePredicate forces me to keep track of what proprietary software I allow.
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "discord" ];
  };
}
