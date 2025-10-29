{
  services.ollama = {
    enable = true;
    environmentVariables = {
      OLLAMA_FLASH_ATTENTION = "1";
    };
  };
}
