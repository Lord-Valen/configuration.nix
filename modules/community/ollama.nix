{
  den.aspects.ollama.nixos =
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
