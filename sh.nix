{ config, pkgs, ... }:

let
  myAliases = {
   ll = "ls -l";
   sudo = "sudo -E";
 };
in
{
  programs.bash = {
    enable = true;
    shellAliases = myAliases;
  };

  programs.zsh = {
    enable = true;
    shellAliases = myAliases;
  };
}
