{
  inputs,
  cell,
}: let
  inherit (cell) nixosProfiles;
in
  with nixosProfiles; rec {
    base = [core fonts gpg];
    chat = [discord telegram matrix];
    office = [zotero latex onlyoffice printing];
    develop = [dev.npm];
    pc =
      base
      ++ chat
      ++ office
      ++ develop
      ++ [audio.common networking yubikey x11.xmonad browser];

    server = base ++ [networking];
    desktop = pc ++ [ipfs];
    laptop = pc ++ [x11.colemak];
  }
