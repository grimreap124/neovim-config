{ config, pkgs, ... }:

let
#  nvf = import (builtins.fetchTarball "https://github.com/notashelf/nvf/archive/master.tar.gz");
  nvf.url = "github:notashelf/nvf";
  myConfig = import ./configuration.nix true;

  neovimWrapped = nvf.lib.neovimConfiguration {
    inherit pkgs;
    modules = [ myConfig ];
  };
in {
  programs.neovim = {
    enable = true;
    package = neovimWrapped.neovim;
  };
}

