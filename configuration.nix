{ config, lib, pkgs, ... }:

{
  imports =
    [ ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "framework";
  networking.networkmanager.enable = true;

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  users.users.jc = {
     isNormalUser = true;
     extraGroups = [ "networkmanager" "wheel" ];
   };

  security.sudo.extraRules = [{
     users = [ "jc" ];
     commands = [{ command = "ALL";
     options = [ "NOPASSWD" ];
    }];
  }];

  environment.systemPackages = with pkgs; [ git neovim ];

  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = true;
  services.openssh.settings.KbdInteractiveAuthentication = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.11";

}

