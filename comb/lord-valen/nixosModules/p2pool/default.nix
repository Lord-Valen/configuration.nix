{
  inputs,
  cell,
  config,
}: let
  inherit (inputs) nixpkgs;
  pkgs = nixpkgs;
  lib = nixpkgs.lib;

  cfg = config.services.p2pool;
  moneroCfg = config.services.monero;
in {
  # TODO: stratum options, socks5 option
  meta.maintainers = with lib.maintainers; [lord-valen];

  options.services.p2pool = with lib; {
    enable = mkEnableOption "the P2Pool service";

    package = mkPackageOption pkgs "p2pool" {};

    mining = {
      enable = mkEnableOption "P2Pool builtin miner";
      threads = mkOption {
        type = types.ints.between 1 64;
        example = literalExpression 6;
        description = "The number of mining threads";
      };
    };

    mini = mkOption {
      type = types.bool;
      default = false;
      description = "Whether or not to mine on the p2pool-mini sidechain";
    };

    light = mkOption {
      type = types.bool;
      default = false;
      description = "Whether or not to enable light mode";
    };

    host = mkOption {
      type = types.nonEmptyStr;
      default = "127.0.0.1";
      description = "The host address of the target Monero node";
    };

    rpcPort = mkOption {
      type = with types; nullOr port;
      default =
        if moneroCfg.enable
        then moneroCfg.rpc.port
        else 18081;
    };

    zmqPort = mkOption {
      type = with types; nullOr port;
      # TODO: add zmq.port option to Monero module
      # default = if moneroCfg.enable
      #           then moneroCfg.zmq.port
      #           else 18083;
      default = 18083;
    };

    address = mkOption {
      type = types.strMatching "^4[0-9AB][A-Za-z0-9]{93}$";
      example = literalExpression "44MnN1f3Eto8DZYUWuE5XZNUtE3vcRzt2j6PzqWpPau34e6Cf4fAxt6X2MBmrm6F9YMEiMNjN6W4Shn4pLcfNAja621jwyg";
      description = "Monero wallet address to receive mining rewards";
    };

    inPeers = mkOption {
      type = types.ints.between 10 450;
      default = 32;
      description = "Max number of incoming connections";
    };

    outPeers = mkOption {
      type = types.ints.between 10 450;
      default = 64;
      description = "Max number of outgoing connections";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.p2pool = {
      description = "p2pool daemon";
      after = ["network-online.target"] ++ lib.optional moneroCfg.enable "monero.service";
      wants = ["network-online.target"] ++ lib.optional moneroCfg.enable "monero.service";
      wantedBy = [
        "multi-user.target"
      ];

      serviceConfig = {
        ExecStart = let
          miniString =
            if cfg.mini
            then "--mini"
            else "";
          lightString =
            if cfg.light
            then "--light-mode"
            else "";
          hostString =
            if (builtins.isString cfg.host)
            then "--host ${cfg.host}"
            else "";
          rpcString =
            if (builtins.isInt cfg.rpcPort)
            then "--rpc-port ${toString cfg.rpcPort}"
            else "";
          zmqString =
            if (builtins.isInt cfg.zmqPort)
            then "--zmq-port ${toString cfg.zmqPort}"
            else "";
          inPeersString = "--in-peers ${toString cfg.inPeers}";
          outPeersString = "--out-peers ${toString cfg.outPeers}";
          addressString = "--wallet ${cfg.address}";
          miningString =
            if cfg.mining.enable
            then "--start-mining ${cfg.mining.threads}"
            else "";
        in ''
          ${lib.getExe' cfg.package "p2pool"}\
            ${miniString}\
            ${lightString}\
            ${hostString}\
            ${rpcString}\
            ${zmqString}\
            ${inPeersString}\
            ${outPeersString}\
            ${addressString}\
            ${miningString}
        '';
        Restart = "always";
      };
    };
  };
}
