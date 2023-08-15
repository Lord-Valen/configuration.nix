{
  inputs,
  cell,
}: let
  inherit (cell) nixosProfiles userProfiles;
in
  with nixosProfiles; rec {
    base = [core cachix fonts gpg userProfiles.root];
    office = [writing printing];
    develop = [javascript];
    pc =
      base
      ++ [pipewire networking yubikey browser];
    pc' =
      pc
      ++ develop
      ++ office
      ++ [chat userProfiles.lord-valen];

    server = base ++ [networking];
    desktop = pc' ++ [kubo];
    laptop = pc' ++ [colemak];
  }
