{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, nvf, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

        mkConfig = config:
          nvf.lib.neovimConfiguration {
            inherit pkgs;
            modules = [ config ];
          };

        maximalConfig = mkConfig (import ./configuration.nix true);
        minimalConfig = mkConfig (import ./configuration.nix false);
      in {
        packages = {
          default = maximalConfig.neovim;
          minimal = minimalConfig.neovim;
        };
      }
    ){
      homeManagerModules.default = import ./home-module.nix;
    };
}
