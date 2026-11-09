{ den, ... }: {
  den.quirks.nixpkgs-overlays.description = "nixpkgs overlays collected from aspects";
  den.aspects.os-overlays = {
    os = { nixpkgs-overlays, lib, ... }: {
      nixpkgs.overlays = nixpkgs-overlays |> lib.unique;
    };
  };
  den.schema.host.includes = [ den.aspects.os-overlays ];

  den.policies.expose-overlays =
    { user, ... }: with den.lib.policy.pipe; from "nixpkgs-overlays" [ expose ];
  den.schema.user.includes = [ den.policies.expose-overlays ];
}
