{
  flake.modules.home-manager.vscode =
    { pkgs, lib, ... }:
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
            "editor.rulers" = [
              100
              120
            ];
            "editor.codeActionsOnSave" = {
              "source.organizeImports" = "explicit";
              "source.fixAll" = "explicit";
            };
            "[typescript]" = {
              "editor.defaultFormatter" = "biomejs.biome";
            };
            "[javascript]" = {
              "editor.defaultFormatter" = "biomejs.biome";
            };
            "[typescriptreact]" = {
              "editor.defaultFormatter" = "biomejs.biome";
            };
            "[javascriptreact]" = {
              "editor.defaultFormatter" = "biomejs.biome";
            };
            "[json]" = {
              "editor.defaultFormatter" = "biomejs.biome";
            };
            "[jsonc]" = {
              "editor.defaultFormatter" = "biomejs.biome";
            };
            "[nix]" = {
              "editor.defaultFormatter" = "jnoortheen.nix-ide";
            };
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
            github.copilot
            github.copilot-chat
            editorconfig.editorconfig
            biomejs.biome
            # vercel.turbo-vcs
          ];
        };
      };
    };
}
