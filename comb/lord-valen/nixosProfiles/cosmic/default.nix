{ inputs }:
{
  imports = [ (inputs.nixos-cosmic + "/nixos/cosmic/module.nix") ];
  services.desktopManager.cosmic.enable = true;
}
