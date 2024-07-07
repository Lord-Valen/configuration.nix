{ inputs, cell }:
let
  inherit (inputs) nixos-hardware;
in
{
  imports = with nixos-hardware.nixosModules; [
    cell.hardwareProfiles.base
    common-pc
    common-cpu-intel-sandy-bridge
    common-gpu-amd-southern-islands
  ];

  hardware = {
    bluetooth = {
      enable = true;
      # Compatibility with PS gamepads
      input.General = {
        ClassicBondedOnly = false;
        UserspaceHID = false;
      };
    };
  };
}
