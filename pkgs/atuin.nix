{ stdenvNoCC, fetchurl }:

let
  assets = {
    aarch64-darwin = {
      target = "aarch64-apple-darwin";
      sha256 = "c2d94ae74da55c644de08ce3eedb0abd5f4a32340f3e9b8e2dade29764ac524c";
    };
    x86_64-darwin = {
      target = "x86_64-apple-darwin";
      sha256 = "ef02c01ba521475be872dc7e725dfa6ad3b3459162a7d642633239f9dfc570eb";
    };
  };
  system = stdenvNoCC.hostPlatform.system;
in
if !(builtins.hasAttr system assets) then
  throw "No pinned Atuin release asset for ${system}"
else
  stdenvNoCC.mkDerivation (finalAttrs: {
    pname = "atuin";
    version = "18.25.1";
    src = fetchurl {
      url = "https://github.com/atuinsh/atuin/releases/download/v${finalAttrs.version}/atuin-${assets.${system}.target}.tar.gz";
      inherit (assets.${system}) sha256;
    };
    dontBuild = true;
    dontStrip = true;
    installPhase = ''
      runHook preInstall
      install -Dm755 atuin "$out/bin/atuin"
      runHook postInstall
    '';
  })
