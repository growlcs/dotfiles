{ home }:
let
  site = "${home}/.local/share/nvim/site";
  mellifluous = builtins.fetchTree {
    type = "github";
    owner = "ramojus";
    repo = "mellifluous.nvim";
    rev = "ec0575bdb63594c5e7fba6eb9607b009aa1fb74e";
    narHash = "sha256-EHYQyIvWTPfXop4gTw4pL7+vXDeanRxMBjbTf7/1tV8=";
  };
in
{
  files = [
    {
      type = "symlink";
      source = mellifluous.outPath;
      target = "${site}/pack/themes/opt/mellifluous.nvim";
    }
    {
      type = "symlink";
      source = ./mellifluous.lua;
      target = "${site}/plugin/mellifluous.lua";
    }
  ];
}
