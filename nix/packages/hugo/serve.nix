{ lib, pkgs, ... }:
pkgs.writeShellScriptBin "hugo-serve" ''
  set -eu -o pipefail

  export PATH="${lib.makeBinPath [
    pkgs.go
    pkgs.hugo
  ]}"

  hugo server --disableFastRender --noHTTPCache --ignoreCache --gc --buildDrafts --source ''${PROJECT_DIR:-.}/src
''
