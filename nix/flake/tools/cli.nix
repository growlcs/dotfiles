{ home, pkgs }:
{
  packages = with pkgs; [
    eza
    nushell
    (callPackage ../../../pkgs/atuin.nix { })
    jujutsu
    lazygit
    delta
    glow
    zoxide
    jq
    yq-go
    direnv
    nix-direnv
  ];

  files = [
    {
      type = "symlink";
      source = "${pkgs.nix-direnv}/share/nix-direnv/direnvrc";
      target = "${home}/.config/direnv/lib/nix-direnv.sh";
    }
  ];
}
