{ inputs, cell }:
let
  inherit (inputs.nixpkgs) lib;
in
{
  # I want to keep proprietary software to a minimum.
  # allowUnfreePredicate forces me to keep track of what proprietary software I allow.
  allowUnfreePredicate =
    pkg:
    lib.elem (lib.getName pkg) [
      "steam"
      "steam-run"
      "steam-original"
      "steam-unwrapped"
      "vcv-rack"
      "osu-lazer-bin"
      "vscode"
      "vscode-extension-ms-dotnettools-vscodeintellicode-csharp"
      "vscode-extension-ms-dotnettools-csdevkit"
      "aspell-dict-en-science"
      "muse-sounds-manager"
      "obsidian"
    ];
  permittedInsecurePackages = [
    "dotnet-runtime-6.0.36"
    "dotnet-runtime-wrapped-6.0.36"
    "dotnet-sdk-6.0.428"
    "dotnet-sdk-wrapped-6.0.428"
    "aspnetcore-runtime-6.0.36"
    "aspnetcore-runtime-wrapped-6.0.36"
    "electron-27.3.11"
  ];
}
