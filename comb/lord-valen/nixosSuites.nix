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
      ++ [audio.common networking yubikey browser];
    pc' =
      pc
      ++ chat
      ++ develop
      ++ office
      ++ [users.lord-valen x11.xmonad];

    server = base ++ [networking];
    desktop = pc' ++ [ipfs];
    laptop = pc' ++ [x11.colemak];
  }
