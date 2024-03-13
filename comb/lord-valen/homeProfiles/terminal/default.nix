{ inputs, cell }:
let
  inherit (inputs) nixpkgs;
in
{
  home.packages = with nixpkgs; [ (iosevka-bin.override { variant = "sgr-iosevka-term-ss05"; }) ];

  programs = {
    alacritty = {
      enable = true;
      settings = {
        cursor.shape = "block";

        font = {
          normal = {
            family = "Iosevka Term SS05";
            style = "Regular";
          };
        };

        colors = {
          transparent_background_colors = true;

          primary = {
            foreground = "#F2F3F7";
            background = "#0C0A20";
          };

          normal = {
            black = "#0C0A20";
            red = "#E61F44";
            green = "#A7DA1E";
            yellow = "#FFD400";
            blue = "#1EA8FC";
            magenta = "#DF86FF";
            cyan = "#42C6FF";
            white = "#F2F3F7";
          };

          cursor = {
            text = "#090819";
            cursor = "#1EA8FC";
          };

          vi_mode_cursor = {
            text = "#090819";
            cursor = "#FFD400";
          };

          line_indicator = {
            foreground = "#F2F3F7";
            background = "#090819";
          };

          search = {
            matches = {
              foreground = "CellForeground";
              background = "CellBackground";
            };

            focused_match = {
              foreground = "CellForeground";
              background = "#1EA8FC";
            };
          };

          selection = {
            text = "CellForeground";
            background = "#1F1147";
          };
        };
      };
    };

    zellij = {
      enable = true;
      settings = {
        # FIXME: hm #4160
        # keybinds = let
        #   bind = key: action: arg: {
        #     _args = [key];
        #     ${action} = arg;
        #   };
        # in {
        #   unbind._repeatedKey = ["m" "n" "e" "i"];

        #   normal.unbind._repeatedKey = ["Alt m" "Alt n" "Alt e" "Alt i"];
        #   normal.bind._repeatedKey = [
        #     (bind "Alt m" "MoveFocusOrTab" "left")
        #     (bind "Alt n" "MoveFocusOrTab" "down")
        #     (bind "Alt e" "MoveFocusOrTab" "up")
        #     (bind "Alt i" "MoveFocusOrTab" "right")
        #     (bind "Alt ," "MoveTab" "left")
        #     (bind "Alt ." "MoveTab" "right")
        #   ];

        #   pane.unbind._repeatedKey = ["x"];
        #   pane.bind._repeatedKey = [
        #     (bind "q" "CloseFocus" null)
        #     (bind "m" "MovePane" "left")
        #     (bind "n" "MovePane" "down")
        #     (bind "e" "MovePane" "up")
        #     (bind "i" "MovePane" "right")
        #   ];

        #   tab.unbind._repeatedKey = ["x"];
        #   tab.bind._repeatedKey = [
        #     (bind "q" "CloseTab" null)
        #     (bind "," "MoveTab" "left")
        #     (bind "." "MoveTab" "right")
        #   ];

        #   resize.bind._repeatedKey = [
        #     (bind "m" "Resize" "left")
        #     (bind "n" "Resize" "up")
        #     (bind "e" "Resize" "down")
        #     (bind "i" "Resize" "right")
        #   ];

        #   move.bind._repeatedKey = [
        #     (bind "m" "MoveFocus" "left")
        #     (bind "n" "MoveFocus" "down")
        #     (bind "e" "MoveFocus" "up")
        #     (bind "i" "MoveFocus" "right")
        #   ];

        #   scroll.bind._repeatedKey = [
        #     (bind "n" "ScrollDown" null)
        #     (bind "e" "ScrollUp" null)
        #   ];
        # };
      };
    };
  };
}
