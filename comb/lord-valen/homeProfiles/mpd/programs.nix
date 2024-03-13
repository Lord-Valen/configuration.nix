{
  inputs,
  cell,
  lib,
}:
{
  ncmpcpp = {
    enable = true;
    bindings = lib.concatLists [
      (lib.mapAttrsToList (key: command: { inherit key command; })
        # Bind key once
        {
          n = "scroll_down";
          e = "scroll_up";
          N = [
            "select_item"
            "scroll_down"
          ];
          E = [
            "select_item"
            "scroll_up"
          ];
        }
      )
      [
        # Bind key many times
        {
          key = "m";
          command = "previous_column";
        }
        {
          key = "m";
          command = "master_screen";
        }
        {
          key = "m";
          command = "volume_down";
        }
        {
          key = "o";
          command = "next_column";
        }
        {
          key = "o";
          command = "slave_screen";
        }
        {
          key = "o";
          command = "volume_up";
        }
      ]
    ];
  };
}
