{ config, lib, pkgs, ... }:

with lib;

let cfg = config.modules.vm;
in {
  options.modules.vm = {
    enable = mkEnableOption "VM module";
    android.enable = mkEnableOption "VM android submodule";
  };

  config = mkIf cfg.enable {
    users.users.${config.user}.extraGroups = [ "libvirtd" ];
    home-manager.users.${config.user}.home.packages = with pkgs;
      [ virt-manager ];

    # Returns a function where a set is expected
    # virtualisation = (mkMerge [
    #   mkIf
    #   cfg.android.enable
    #   (mkMerge [
    #     (mkIf config.modules.x11.enable { anbox.enable = true; })
    #     (mkIf config.modules.wayland.enable { waydroid.enable = true; })
    #   ])
    #   { libvirtd.enable = true; }
    # ]);
  };
}
