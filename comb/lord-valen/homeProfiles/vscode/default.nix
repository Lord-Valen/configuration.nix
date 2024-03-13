{
  inputs,
  cell,
  pkgs,
  lib,
}:
let
  inherit (pkgs) vscode-utils;
in
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    enableExtensionUpdateCheck = false;
    mutableExtensionsDir = false;
    extensions = lib.concatLists [
      (with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        kamadorueda.alejandra
        xaver.clang-format
        esbenp.prettier-vscode
        dbaeumer.vscode-eslint
        esbenp.prettier-vscode
        kahole.magit
      ])
      (vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "outrun";
          publisher = "samrapdev";
          version = "0.2.2";
          sha256 = "sha256-d0LPpUQbz9g9Scv24oS13vQ0X4lA35unRBgRWM+G+5s=";
        }
        {
          name = "vim-colemakdh";
          publisher = "zaksingh";
          version = "1.24.3";
          sha256 = "sha256-CcaO6ankvQtE0VsAGtPXQikTmTTrmKR10MNSRojqK24=";
        }
        {
          name = "spellbound";
          publisher = "mpoteat-vsce";
          version = "0.0.3";
          sha256 = "sha256-KANKsWl6LH3pAVMxctzeQ5mCfeVJtI9lxSrTUWLHH2k=";
        }
        {
          name = "vscodeintellicode";
          publisher = "VisualStudioExptTeam";
          version = "1.2.30";
          sha256 = "sha256-f2Gn+W0QHN8jD5aCG+P93Y+JDr/vs2ldGL7uQwBK4lE=";
        }
      ])
    ];
  };
}
