{
  inputs,
  cell,
}: let
  lib = inputs.nixpkgs.lib // builtins;
in
  lib.mapAttrs (_: inputs.std.lib.dev.mkShell) {
    default = {...}: {
      name = "Hive";
      nixago = with inputs.std-data-collection.data.configs; [
        treefmt
        lefthook
        editorconfig
        (conform {data = {inherit (inputs) cells;};})
      ];
      commands = let
        inherit (inputs) nixos-generators colmena;
        hexagon = attrset: attrset // {category = "hexagon";};
      in [
        (hexagon {package = colmena.packages.colmena;})
        (hexagon {package = nixos-generators.packages.nixos-generate;})
        (hexagon {
          name = "spawn-larva";
          help = "Spawns larva, the x86_64-linux iso bootstrapper.";
          command = ''
            echo "Boostrap image is building..."
            if path=$(nix build $PRJ_ROOT#nixosConfigurations._queen-o-larva.config.system.build.isoImage --print-out-paths);
            then
               echo "Boostrap image build finished."
            else
               echo "Boostrap image build failed."
            fi
          '';
        })
      ];
    };
  }
