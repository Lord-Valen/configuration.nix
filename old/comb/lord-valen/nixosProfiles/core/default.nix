{
  inputs,
  cell,
  lib,
}:
{
  time.timeZone = lib.mkDefault "Canada/Eastern";
  boot.tmp.cleanOnBoot = true;
}
