{
  flake.modules.nixos.colemak = {
    console.useXkbConfig = true;
    services.xserver.xkb.variant = "colemak_dh";
  };
}
