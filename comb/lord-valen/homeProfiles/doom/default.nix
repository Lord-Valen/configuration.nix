{ inputs, cell }:
let
  inherit (inputs) nixpkgs;
in
{
  fonts.fontconfig.enable = true;

  programs.emacs = {
    enable = true;
    package = nixpkgs.emacs29;
    extraPackages =
      epkgs: with epkgs; [
        # :term vterm
        vterm
      ];
  };

  services.emacs = {
    enable = true;
    defaultEditor = true;
    socketActivation.enable = true;
    client.enable = true;
  };
}
