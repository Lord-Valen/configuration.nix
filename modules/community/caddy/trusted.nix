{
  flake.lib.caddy =
    let
      mkTrustedWith =
        {
          prelude ? "",
          predicate ? "remote_ip private_ranges",
          handler,
          extraConfig ? "",
        }:
        ''
          ${prelude}

          @trusted ${predicate}
          handle @trusted {
            ${handler}
          }

          ${extraConfig}

          handle {
            abort
          }
        '';
    in
    {
      inherit mkTrustedWith;
      mkTrusted = handler: mkTrustedWith { inherit handler; };
    };
}
