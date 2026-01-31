{
  flake.aspects.drone.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        betaflight-configurator
      ];
      services.udev.packages = with pkgs; [
        platformio-core.udev # Install udev rules for ExpressLRS configurator.
      ];
    };
}
