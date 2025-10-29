{
  flake.modules.nixos.ollama =
    { pkgs, ... }:
    {
      services.ollama = {
        enable = true;
        environmentVariables = {
          OLLAMA_FLASH_ATTENTION = "1";
        };
      };
      environment.systemPackages = with pkgs; [
        ollama
      ];
    };
}
