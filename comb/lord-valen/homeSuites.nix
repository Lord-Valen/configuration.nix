{
  inputs,
  cell,
}: let
  inherit (cell) homeProfiles;
in {
  base = with homeProfiles; [
    git.common
    direnv
    xdg
  ];
}
