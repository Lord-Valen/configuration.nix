{
  inputs,
  cell,
  pkgs,
}:
let
  inherit (inputs) nixos-hardware;
in
{
  imports = with nixos-hardware.nixosModules; [
    cell.hardwareProfiles.base
    common-pc-laptop-hdd
    common-cpu-amd
    common-gpu-amd
  ];

  environment.systemPackages = with pkgs; [ bluez ];
  services.blueman.enable = true;

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
  };

  swapDevices = [ { device = "/swap/swapfile"; } ];
}
