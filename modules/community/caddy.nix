{
  ...
}:
{
  flake.aspects.caddy.nixos = {
    services.caddy = {
      enable = true;
      email = "lord_valen@proton.me";
    };
  };
}
