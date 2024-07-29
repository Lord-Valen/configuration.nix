{ pkgs, lib }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    enableExtensionUpdateCheck = false;
    mutableExtensionsDir = false;
    extensions = with pkgs.vscode-extensions; [
      visualstudioexptteam.vscodeintellicode
      jnoortheen.nix-ide
      xaver.clang-format
      esbenp.prettier-vscode
      dbaeumer.vscode-eslint
      kahole.magit
      ms-dotnettools.csdevkit
    ];
  };
}
