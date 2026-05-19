{
  den.aspects.pipewire.nixos = {
    services.pipewire = {
      enable = true;
      audio.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    security.rtkit.enable = true;
  };
  den.aspects.pc.nixos =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      environment.systemPackages =
        with pkgs;
        lib.mkIf (config.services.pipewire.enable) [
          qpwgraph
        ];
    };
}
