{ self, lib, pkgs, system, ... }:
pkgs.mkShell {
  buildInputs = [
    pkgs.hugo
    pkgs.go
  ] ++ (lib.attrValues self.packages."${system}");
  shellHook = ''
    current_dir="$PWD"
    while [ "$current_dir" != "/" ]; do
      if [ -e "$current_dir/flake.nix" ]; then
        export PROJECT_DIR="$current_dir"
        break
      fi
      current_dir=$(dirname "$current_dir")
    done

    echo "Hugo Version      : $(hugo version)"
    echo "Go Version        : $(go version)"
    echo "Project Directory : ''${PROJECT_DIR}"
  '';
}
