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

        {
          category = "nix";
          name = "switch";
          help = "Switch configurations";
          command = "sudo nixos-rebuild switch --flake $PRJ_ROOT $@";
        }
        {
          category = "nix";
          name = "boot";
          help = "Switch boot configuration";
          command = "sudo nixos-rebuild boot --flake $PRJ_ROOT $@";
        }
        {
          category = "nix";
          name = "test";
          help = "Test configuration";
          command = "sudo nixos-rebuild test --flake $PRJ_ROOT $@";
        }
        {
          category = "nix";
          name = "update";
          help = "Update inputs";
          command = "nix flake update $PRJ_ROOT $@";
        }
        {
          category = "nix";
          name = "check";
          help = "Check flake";
          command = "nix flake check $PRJ_ROOT $@";
        }
      ];
    };
  }
