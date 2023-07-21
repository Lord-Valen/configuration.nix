{
  inputs,
  cell,
}: let
  inherit (cell) nixosProfiles;
in
  with nixosProfiles; rec {
    base = [core cachix fonts gpg users.root];
    chat = [discord telegram matrix];
    office = [zotero latex onlyoffice printing];
    develop = [dev.npm];
    pc =
      base
      ++ [pipewire networking yubikey browser];
    pc' =
      pc
      ++ chat
      ++ develop
      ++ office
      ++ [users.lord-valen];

    server = base ++ [networking];
    desktop = pc' ++ [kubo];
    laptop = pc' ++ [x11.colemak];
  }
