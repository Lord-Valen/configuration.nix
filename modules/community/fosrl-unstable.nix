{ inputs, ... }:
{
  # 26.05's fosrl-newt (1.12.4) predates a control-websocket hang fix.
  # Paired with fosrl-gerbil from the same snapshot to avoid cross-version drift.
  flake.overlays.fosrl-unstable =
    final: _prev:
    let
      unstable = import inputs.nixpkgs-unstable { inherit (final) system; };
    in
    {
      fosrl-newt = unstable.fosrl-newt;
      fosrl-gerbil = unstable.fosrl-gerbil;
      # Same network detection as of 1.21!
      fosrl-pangolin = unstable.fosrl-pangolin;
      pangolin-cli = unstable.pangolin-cli;
    };
}
