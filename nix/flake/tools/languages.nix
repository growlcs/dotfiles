{ pkgs }:
{
  packages = with pkgs; [
    rustc
    cargo
    rust-analyzer
    rustfmt
    clippy

    zig
    zls

    go
    gopls
    gofumpt

    jdk
    jdt-language-server
    google-java-format

    lean4

    nodejs
    typescript
    typescript-language-server
    prettier

    nil
    nixfmt
  ];
}
