{ pkgs, lib }:
let
  inherit (pkgs.vscode-utils) buildVscodeMarketplaceExtension;
in
{
  home.packages = [
    (
      with pkgs.dotnetCorePackages;
      combinePackages [
        sdk_8_0
        sdk_9_0
      ]
    )
  ];
  programs.vscode = {
    enable = true;
    profiles.default = {
      userSettings = {
        "telemetry.telemetryLevel" = "off";
        "dotnetAcquisitionExtension.enableTelemetry" = false;

        "editor.formatOnSave" = true;
        "editor.formatOnPaste" = true;
        "git.openRepositoryInParentFolders" = "always";
      };
      extensions = with pkgs.vscode-extensions; [
        visualstudioexptteam.vscodeintellicode
        mkhl.direnv
        jnoortheen.nix-ide
        ms-dotnettools.csdevkit
        ms-dotnettools.csharp
        ms-dotnettools.vscodeintellicode-csharp
        ms-dotnettools.vscode-dotnet-runtime
      ];
    };
  };
}
