{ autolith, helix, home, lace, pkgs, toolPkgs }:
if builtins.substring 0 1 home != "/" then
  throw "Hjem needs an absolute HOME. Export it and pass --impure."
else
let
  tools = [
    (import ./tools/helix {
      inherit home;
      package = helix.packages.${pkgs.stdenv.hostPlatform.system}.default;
      laceHelixRuntime = lace.packages.${pkgs.stdenv.hostPlatform.system}.helix-runtime;
    })
    (import ./tools/rex.nix { inherit pkgs; })
    (import ./tools/neovim { inherit home; })
    (import ./tools/autolith.nix { inherit autolith pkgs; })
    (import ./tools/cli.nix { inherit home; pkgs = toolPkgs; })
    (import ./tools/languages.nix { pkgs = toolPkgs; })
  ];
in
{
  version = 3;
  files = map (
    file:
    if builtins.isPath (file.source or null) then
      file // {
        source = "${pkgs.writeText (builtins.baseNameOf file.source) (builtins.readFile file.source)}";
      }
    else
      file
  ) ([
    {
      type = "symlink";
      source = ../../home/files/.config/example;
      target = "${home}/.config/example";
    }
  ] ++ builtins.concatMap (tool: tool.files or [ ]) tools);
  packages = builtins.concatMap (tool: tool.packages or [ ]) tools ++ [
    lace.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
