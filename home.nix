{ lib, config, pkgs, ... }:

{
  imports = [
    "${fetchTarball "https://github.com/msteen/nixos-vscode-server/tarball/master"}/modules/vscode-server/home.nix"
  ];

  home = {
    username = lib.mkDefault "damien";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = "24.05";
  };

  services = {
    vscode-server.enable = true;
  };

  programs = {
    git = {
      enable = true;
      userName = "Damien Wilson";
      userEmail = "damien@absurd.engineering";
    };
  };

  home.packages = with pkgs; [
  ];
}
