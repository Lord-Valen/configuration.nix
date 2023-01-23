{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.p2pool;
in {
  options = {
    services.p2pool = {
      enable = mkEnableOption (lib.mdDoc "Monero P2Pool service");

      address = mkOption {
        type = types.str;
        default = "";
        description = lib.mdDoc ''
          Target Monero address for send mining rewards.
        '';
      };

      mini = mkOption {
        type = types.bool;
        default = false;
        description = lib.mdDoc ''
          Whether or not to mine on the p2pool-mini sidechain.
        '';
      };

      outPeers = mkOption {
        type = types.int;
        default = 64;
        description = lib.mdDoc ''
          Max number of outgoing connections.
        '';
      };

      inPeers = mkOption {
        type = types.int;
        default = 32;
        description = lib.mdDoc ''
          Max number of incoming connections.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    services = {
      monero = {
        enable = true;
        mining.enable = false;
        priorityNodes = [
          "node.supportxmr.com:18080"
          "nodes.hashvault.pro:18080"
        ];
        extraConfig = ''
          zmq-pub=tcp://127.0.0.1:18083

          out-peers=${toString cfg.outPeers}
          in-peers=${toString cfg.inPeers}
        '';
      };

      xmrig = {
        enable = true;
        settings.pools = [
          {
            url = "127.0.0.1:3333";
          }
        ];
      };
    };

    systemd.services.p2pool = {
      description = "p2pool daemon";
      after = ["network.target"];
      wants = ["monero.service"];
      wantedBy = [
        "multi-user.target"
        "xmrig.service"
      ];

      serviceConfig = {
        ExecStart = let
          miniString =
            if cfg.mini
            then "--mini"
            else "";
        in "${pkgs.p2pool}/bin/p2pool ${miniString} --host 127.0.0.1 --wallet ${cfg.address}";
        Restart = "always";
      };
    };

    assertions = singleton {
      assertion = cfg.enable -> cfg.address != "";
      message = ''
        You need a Monero address to receive mining rewards:
        specify one using option p2pool.address.
      '';
    };
  };
}
