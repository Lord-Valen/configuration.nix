{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
in {
  fonts.fontconfig.enable = true;

  services.emacs = {
    enable = true;
    defaultEditor = true;
  };
}
