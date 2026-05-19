{ den, ... }:
{
  den.aspects.vscode.includes = [
    (den.batteries.unfree [
      "vscode"
      "vscode-extension-ms-dotnettools-csdevkit"
      "vscode-extension-ms-dotnettools-csharp"
      "vscode-extension-ms-dotnettools-vscodeintellicode-csharp"
      "vscode-extension-github-copilot"
      "vscode-extension-github-copilot-chat"
    ])
  ];
}
