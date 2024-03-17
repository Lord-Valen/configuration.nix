{
  inputs,
  cell,
  config,
  options,
  pkgs,
  lib,
}:
let
  inherit (inputs) home-manager;

  cfg = config.services.sunshine;

  conf = pkgs.formats.conf { };
  json = pkgs.formats.json { };
in
{
  options.services.sunshine =
    let
      inherit (lib)
        mkEnableOption
        mkOption
        literalExpression
        types
        ;
    in
    {
      enable = mkEnableOption "sunshine, a gamestream server";

      package = mkOption {
        type = types.package;
        default = pkgs.sunshine;
        defaultText = literalExpression "pkgs.sunshine";
        description = "The `sunshine` package to use";
      };

      apps = mkOption {
        type = json.type;
        default = { };
        example = literalExpression ''
          {
            env.path = "$(PATH):$(HOME)/.local/bin";
            apps = [
              {
                name = "Desktop";
                image-path = "desktop.png";
              }
              {
                name = "Steam Big Picture";
                image-path = "desktop.png";
                detached = [ "setsid steam steam://open/bigpicture" ];
              }
            ];
          }
        '';
        description = "Sunshine app configurations";
      };

      settings = mkOption {
        type = conf.type;
        default = { };
        example = literalExpression ''
          {
            # TODO: do this
          }
        '';
        description = ''
          The settings that will be written to the sunshine configuration file.
        '';
      };
    };

  config =
    let
      inherit (lib) mkIf;
    in
    mkIf cfg.enable {
      xdg.configFile."sunshine/sunshine.conf" = mkIf (cfg.settings != { }) {
        source = conf.generate "sunshine-sunshine.conf";
      };
      xdg.configFile."sunshine/apps.json" = mkIf (cfg.apps != { }) {
        source = json.generate "sunshine-apps.json";
      };
    };

  meta = with lib; {
    maintainers = with maintainers; [ lord-valen ];
  };
}
