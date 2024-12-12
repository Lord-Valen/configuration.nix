{ pkgs, lib }:
let
  inherit (pkgs.vscode-utils) buildVscodeMarketplaceExtension;
in
{
  programs.vscode = {
    enable = true;
    userSettings = {
      "telemetry.telemetryLevel" = "off";
      "git.openRepositoryInParentFolders" = "always";
      "dotnetAcquisitionExtension.enableTelemetry" = false;
      "dotnetAcquisitionExtension.existingDotnetPath" =
        let
          dotnet-sdk =
            with pkgs.dotnetCorePackages;
            lib.getExe (combinePackages [
              sdk_8_0
              sdk_9_0
            ]);
        in
        [
          {
            extensionId = "ms-dotnettools.csharp";
            path = dotnet-sdk;
          }
          {
            extensionId = "ms-dotnettools.csdevkit";
            path = dotnet-sdk;
          }
        ];
    };
    extensions = with pkgs.vscode-extensions; [
      visualstudioexptteam.vscodeintellicode
      mkhl.direnv
      jnoortheen.nix-ide
      ms-dotnettools.csdevkit
      ms-dotnettools.csharp
      # ms-dotnettools.vscodeintellicode-csharp
      # ms-dotnettools.vscode-dotnet-runtime
    ];
  };
}
