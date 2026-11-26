{ autolith, pkgs }:
let
  packages = autolith.packages.${pkgs.stdenv.hostPlatform.system} or { };
in
{
  packages = if packages ? default then [ packages.default ] else [ ];
}
