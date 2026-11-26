{ home, package, laceHelixRuntime }:
let
  laceRuntime = "${laceHelixRuntime}/share/helix/runtime";
in
{
  packages = [
    (package.override {
      grammarOverlays = [
        (_final: prev: {
          gotmpl = prev.gotmpl.overrideAttrs (_: {
            src = (builtins.fetchTree {
              type = "github";
              owner = "ngalaiko";
              repo = "tree-sitter-go-template";
              rev = "395a33e08e69f4155156f0b90138a6c86764c979";
              narHash = "sha256-YlPX74tEgCxGm2GYqYvQ0ouzTZ4x5/R+hkP+lBuOLGw=";
            }).outPath;
          });
        })
      ];
    })
  ];
  files = [
    {
      type = "symlink";
      source = "${laceRuntime}/grammars/lace.so";
      target = "${home}/.config/helix/runtime/grammars/lace.so";
    }
    {
      type = "symlink";
      source = "${laceRuntime}/queries/lace";
      target = "${home}/.config/helix/runtime/queries/lace";
    }
    {
      type = "symlink";
      source = ./config.toml;
      target = "${home}/.config/helix/config.toml";
    }
    {
      type = "symlink";
      source = ./languages.toml;
      target = "${home}/.config/helix/languages.toml";
    }
    {
      type = "symlink";
      source = ./themes/ayu_evolve_transparent.toml;
      target = "${home}/.config/helix/themes/ayu_evolve_transparent.toml";
    }
    {
      type = "symlink";
      source = ./themes/living-code-night.toml;
      target = "${home}/.config/helix/themes/living-code-night.toml";
    }
    {
      type = "symlink";
      source = ./themes/living-code-adaptive.toml;
      target = "${home}/.config/helix/themes/living-code-adaptive.toml";
    }
  ] ++ map (name: {
    type = "symlink";
    source = ./themes + "/${name}.toml";
    target = "${home}/.config/helix/themes/${name}.toml";
  }) [ "mellifluous-dark" "mellifluous-light" ];
}
