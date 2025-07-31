{ lib, pkgs, ... }:
pkgs.writeShellScriptBin "hugo-build" ''
  set -eu -o pipefail

  export PATH="${lib.makeBinPath [
    pkgs.coreutils
    pkgs.git
    pkgs.go
    pkgs.hugo
    pkgs.zip
  ]}"

  hugo build --ignoreCache --gc --source ''${PROJECT_DIR:-.}/src --destination "''${PROJECT_DIR:-.}/public"
  #zip -qr "''${PROJECT_DIR:-.}/public.zip" "''${PROJECT_DIR:-.}/public"
  (cd "''${PROJECT_DIR:-.}/public" && zip -qr "''${PROJECT_DIR:-.}/public.zip" ./)
  [ -f "''${PROJECT_DIR:-/tmp/failsafe}/public/sitemap.xml" ] && rm -rf "''${PROJECT_DIR:-/tmp/failsafe}/public"
''
