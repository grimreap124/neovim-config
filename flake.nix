{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf";
  };

  outputs = {nixpkgs, ...} @ inputs: {
    packages."x86_64-linux" = let
      mkConfig = config:
        inputs.nvf.lib.neovimConfiguration {
          inherit (nixpkgs.legacyPackages."x86_64-linux") pkgs;
          modules = [config];
        };

      maximalConfig = mkConfig (import ./configuration.nix true);
      minimalConfig = mkConfig (import ./configuration.nix false);
    in {
      default = maximalConfig.neovim;
      minimal = minimalConfig.neovim;
    };
  };
}
