{ pkgs }:
{
  packages = pkgs.lib.optionals pkgs.stdenv.hostPlatform.isDarwin [
    (pkgs.writeShellScriptBin "rex" ''
      cli='/Applications/Rex.app/Contents/Helpers/Rex Server.rex/Contents/MacOS/rex'
      if [ ! -x "$cli" ]; then
        printf '%s\n' 'rex: install Rex.app in /Applications to use its CLI' >&2
        exit 127
      fi
      exec "$cli" "$@"
    '')
  ];
}
