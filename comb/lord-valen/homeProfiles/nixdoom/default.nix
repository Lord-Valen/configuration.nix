{
  inputs,
  cell,
  pkgs,
}:
{
  imports = [ inputs.nix-doom-emacs.hmModule ];

  fonts.fontconfig.enable = true;

  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./_doom.d;
    extraPackages = with pkgs; [
      # :term vterm
      emacsPackages.vterm
    ];
    emacsPackagesOverlay = self: super: { };
  };

  services.emacs = {
    enable = true;
    defaultEditor = true;
    socketActivation.enable = true;
  };
}
