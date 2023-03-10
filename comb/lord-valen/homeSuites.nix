{
  inputs,
  cell,
}: {
  base = [];
  emacs = [];
}
#   home = {
#     importables = let
#       profiles = lib.rakeLeaves ./home/profiles;
#     in {
#       profiles = profiles;
#       suites = let
#         inherit
#           (profiles)
#           direnv
#           git
#           xdg
#           ;
#       in {base = [direnv git.common xdg];};
#     };
#     imports = [(lib.importExportableModules ./home/modules)];
#     modules = [inputs.nix-doom-emacs.hmModule];
#     users = {
#       nixos = {
#         suites,
#         profiles,
#         ...
#       }: {
#         home.stateVersion = "22.05";
#         imports = suites.base;
#       };
#       lord-valen = {
#         suites,
#         profiles,
#         ...
#       }: {
#         home.stateVersion = "22.05";
#         imports =
#           suites.base
#           ++ (
#             let
#               inherit (profiles) git doom wallpaper xmobar shell;
#             in [doom wallpaper xmobar git.valen shell.nushell]
#           );
#       };
#     };
#   };

