{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf";
  };

  outputs = {nixpkgs, ...} @ inputs: {
    packages."x86_64-linux" = let
      maximalConfig = import ./configuration.nix true;
      neovimConfigured = inputs.nvf.lib.neovimConfiguration {
        inherit (nixpkgs.legacyPackages."x86_64-linux") pkgs;
        modules = [maximalConfig];
      };
    in {
      default = neovimConfigured.neovim;
    };
  };
}
