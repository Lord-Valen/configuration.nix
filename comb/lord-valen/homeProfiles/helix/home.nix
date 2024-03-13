{ inputs, cell }:
{
  programs = with inputs.nixpkgs; [
    nil
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    nodePackages.yaml-language-server
    taplo
    nodePackages.prettier
    rust-analyzer
    haskell-language-server
    bash-language-server
    clang-tools
    marksman
  ];
}
