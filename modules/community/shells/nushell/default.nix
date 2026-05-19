{ den, ... }:
{
  den.aspects.nushell = {
    includes = with den.aspects; [ shell ];
    homeManager = {
      programs.nushell = {
        enable = true;
        configFile.source = ./config.nu;
        settings = {
          show_banner = false;
          filesize.unit = "binary";
        };
      };
    };
  };
}
