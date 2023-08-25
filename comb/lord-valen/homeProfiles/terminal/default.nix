{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
in {
  home.packages = with nixpkgs; [
    (nerdfonts.override {fonts = ["FiraCode"];})
    fira
  ];

  programs = {
    alacritty = {
      enable = true;
      settings = {
        font = {
          normal = {
            family = "FiraCode Nerd Font Mono";
            style = "Regular";
          };

          italic = {
            family = "Fira Sans";
            style = "Italic";
          };

          bold_italic = {
            family = "Fira Sans";
            style = "Bold Italic";
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
