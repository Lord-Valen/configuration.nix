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
        (final: prev: {
          llm-agents = {
            inherit (inputs.llm-agents.packages.${prev.stdenv.hostPlatform.system})
              hermes-agent
              hermes-hud;
          };
        })
      ];
    };

    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          llm-agents.hermes-agent
          llm-agents.hermes-hud
        ];
      };
  };
}