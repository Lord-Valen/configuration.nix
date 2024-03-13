{ inputs, cell }:
let
  inherit (inputs) common nixpkgs nixos-hardware;
  inherit (common) hardware;
in
{
  imports = with nixos-hardware.nixosModules; [
    common-pc-laptop-hdd
    common-cpu-amd
    common-gpu-amd
  ];

  environment.systemPackages = with nixpkgs; [ bluez ];
  services.blueman.enable = true;

  hardware = hardware // {
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
  };

  swapDevices = [ { device = "/swap/swapfile"; } ];
}
