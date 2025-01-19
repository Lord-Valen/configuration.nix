{ cell }:
{
  hardware.opentabletdriver = {
    enable = true;
    package = cell.pkgs-unstable.opentabletdriver;
  };
}
