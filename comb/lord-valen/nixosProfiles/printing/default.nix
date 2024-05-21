{
  inputs,
  cell,
  pkgs,
}:
{
  imports = with cell.nixosProfiles; [ avahi ];
  hardware.sane = {
    enable = true;
    extraBackends = with pkgs; [
      hplip
      sane-airscan
    ];
    disabledDefaultBackends = [ "escl" ];
  };

  programs.system-config-printer.enable = true;
  environment.systemPackages = with pkgs; [ simple-scan ];

  services = {
    ipp-usb.enable = true;
    printing = {
      enable = true;
      drivers = with pkgs; [
        gutenprint
        gutenprintBin
        foomatic-filters
        brlaser
        hplip
      ];
    };

    saned.enable = true;
  };
}
