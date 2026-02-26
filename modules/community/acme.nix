{
  flake.aspects.acme.nixos = {
    security.acme = {
      acceptTerms = true;
      defaults.email = "lord_valen@proton.me";
    };
  };
}
