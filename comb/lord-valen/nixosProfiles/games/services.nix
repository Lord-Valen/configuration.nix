{
  inputs,
  cell,
  pkgs, # FIXME: attribute 'pkgs' missing
}:
let
  pkgs = inputs.nixpkgs;
in
{
  avahi = {
    enable = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };
  xserver.desktopManager.retroarch = {
    enable = true;
    package = pkgs.retroarchFull;
  };
}
