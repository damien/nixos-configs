{ config, pkgs, ... }:

let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  damien = {
    isNormalUser = true;
    extraGroups = ifTheyExist [
      "wheel"
    ]
  }
}