{ den, inputs, ... }:
{
  den.aspects.hermes-agent = {
    nixos = {
      nix.settings = {
        extra-trusted-substituters = [ "https://cache.numtide.com" ];
        extra-trusted-public-keys = [
          "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
        ];
      };
      nixpkgs.overlays = [
        (final: _: {
          hermes-agent = inputs.llm-agents.packages.${final.system}.hermes-agent;
          hermes-hud = inputs.llm-agents.packages.${final.system}.hermes-hud;
        })
      ];
    };

    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          hermes-agent
          hermes-hud
        ];
      };
  };
}
