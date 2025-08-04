{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
  };

  outputs = { systems, nixpkgs, ...}@inputs:
  let
    eachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f nixpkgs.legacyPackages.${system});
  in {
    devShells = eachSystem (pkgs: {
      default = pkgs.mkShell {
        buildInputs = [
          pkgs.hugo
          pkgs.go
        ];
        shellHook = ''
          ${pkgs.coreutils-full}/bin/echo "Hugo: $(hugo version)"
          ${pkgs.coreutils-full}/bin/echo "Go: $(go version)"
          #${pkgs.hugo}/bin/hugo server --disableFastRender --noHTTPCache --gc --buildDrafts --source ./src
        '';
      };
    });
  };
}
