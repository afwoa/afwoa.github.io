{
  description = "HUGO Website for afwoa.com";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }@inputs:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs { inherit system; };
      lib = pkgs.lib;
    in {
      devShells = {
        default = import ./nix/devShells/default.nix { inherit self lib pkgs system; };
      };
      packages = {
        hugo-serve = import ./nix/packages/hugo/serve.nix { inherit lib pkgs; };
        hugo-build = import ./nix/packages/hugo/build.nix { inherit lib pkgs; };
      };
    });
}
