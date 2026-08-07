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
        inputs.llm-agents.overlays.shared-nixpkgs
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
