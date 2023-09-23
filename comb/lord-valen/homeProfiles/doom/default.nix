{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
in {
  imports = [inputs.nix-doom-emacs.hmModule];

  fonts.fontconfig.enable = true;

  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./_doom.d;
    extraPackages = with nixpkgs; [
      # :term vterm
      emacsPackages.vterm
    ];
    emacsPackagesOverlay = self: super: {
    };
  };

  services.emacs = {
    enable = true;
    defaultEditor = true;
    socketActivation.enable = true;
  };
}
