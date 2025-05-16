{ inputs, cell }:
{
  programs.anyrun = {
    enable = true;
    config = {
      plugins = with inputs.anyrun.packages; [
        applications
        shell
        randr
      ];

      y.fraction = 0.35;
      width.fraction = 0.5;
      closeOnClick = true;
      showResultsImmediately = true;
    };

    extraCss = ''
      #window {
        background-color: rgba(0, 0, 0, 0);
      }

      box#main {
        border-radius: 10px;
        background-color: @theme_bg_color;
      }

      list#main {
        background-color: rgba(0, 0, 0, 0);
        border-radius: 10px;
      }

      list#plugin {
        background-color: rgba(0, 0, 0, 0);
      }

      label#match-desc {
        font-size: 10px;
      }

      label#plugin {
        font-size: 14px;
      }
    '';

    extraConfigFiles = {
      "applications.ron".text = ''
        Config(
          desktop_actions: false,
          max_entries: 10,
          terminal: Some("alacritty"),
        )
      '';
      "randr.ron".text = ''
        Config(
          prefix: ":dp",
          max_entries: 10,
        )
      '';
      "shell.ron".text = ''
        Config(
          prefix: ":sh",
          shell: Some("nu"),
        )
      '';
    };
  };
}
