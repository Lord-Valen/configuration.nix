{
  den.aspects.colemak.nixos = {
    console.useXkbConfig = true;
    services.xserver.xkb.variant = "colemak_dh";
  };
}
