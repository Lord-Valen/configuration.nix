{ config, lib, pkgs, ... }:

with lib;

let cfg = config.modules.emacs.academicWriting;
in {
  options.modules.emacs.academicWriting = {
    enable = mkEnableOption "Emacs academic writing submodule";
    scheme = mkOption {
      type = types.str;
      default = "scheme-full";
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.${config.user}.home.packages = with pkgs;
      [ texlive.combined.${cfg.scheme} ];
  };
}
