{ autolith, helix, lace, nixpkgs, tool-nixpkgs, ... }:
{
  hjemConfigurations.default =
    let
      config = import ./nix/flake/hjem.nix {
        inherit autolith helix lace;
        home = builtins.getEnv "HOME";
        pkgs = nixpkgs.legacyPackages.${builtins.currentSystem};
        toolPkgs = tool-nixpkgs.legacyPackages.${builtins.currentSystem};
      };
    in
    {
      manifest = builtins.removeAttrs config [ "packages" ];
      inherit (config) packages;
    };
}
