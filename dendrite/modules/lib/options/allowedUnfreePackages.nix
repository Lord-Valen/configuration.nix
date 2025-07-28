/*
  MIT License

  Copyright (c) 2024 Shahar "Dawn" Or

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.
*/
{ lib, config, ... }:
{
  options.nixpkgs.allowedUnfreePackages = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
  };

  config = {
    text.readme.parts.allowedUnfreePackages = ''
      ## Unfree packages

      Which unfree packages are allowed is configured at the flake level via an option.
      That is then used in the configuration of Nixpkgs.
      See definition at [`unfree-packages.nix`](modules/lib/options/unfree-packages.nix).
      See usage at [`vscode`](modules/community/vscode/default.nix).
      The value of this option is available as a flake output:

      ```console
      $ nix eval .#meta.nixpkgs.allowedUnfreePackages
      ```
    '';

    flake = {
      modules =
        let
          predicate = pkg: builtins.elem (lib.getName pkg) config.nixpkgs.allowedUnfreePackages;
        in
        {
          nixos.base.nixpkgs.config.allowUnfreePredicate = predicate;

          homeManager.base = args: {
            nixpkgs.config = lib.mkIf (!(args.hasGlobalPkgs or false)) {
              allowUnfreePredicate = predicate;
            };
          };
        };

      meta.nixpkgs.allowedUnfreePackages = config.nixpkgs.allowedUnfreePackages;
    };
  };
}
