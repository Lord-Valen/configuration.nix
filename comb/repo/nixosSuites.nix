{
  inputs,
  cell,
}: let
  inherit (cell) nixosProfiles;
in {larva = [nixosProfiles.bootstrap];}
