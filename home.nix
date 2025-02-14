{ lib, config, pkgs, ... }:

{
  home = {
    username = lib.mkDefault "damien";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = "24.05";
  };

  services = {};

  programs = {
    git = {
      enable = true;
      userName = "Damien Wilson";
      userEmail = "damien@absurd.engineering";
    };

    home-manager.enable = true;
  };

  home.packages = with pkgs; [
  ];
}
