{
  pkgs,
  cell,
}:
{
  imports = [ cell.nixosProfiles.tablet ];
  environment.systemPackages = with pkgs; [ cell.pkgs-unstable.osu-lazer-bin ];
}
