{ config, lib, pkgs, ... }:

{
  imports =
    [ ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.kernelModules = [ "amdgpu" ];  
  boot.initrd.systemd.enable = true;
  boot.plymouth.enable = true;

  networking.hostName = "framework";
  networking.networkmanager.enable = true;

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = with pkgs; [
    geary
    epiphany
    simple-scan
    totem
    yelp
    cheese
    baobab
    gnome-tour
    gnome-maps
    gnome-music
    gnome-photos
    gnome-logs
    gnome-font-viewer
    gnome-calendar
    gnome-clocks
    gnome-characters
    gnome-contacts
    gnome-weather
  ];

  services.xserver.excludePackages = [ pkgs.xterm ];

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

  environment.systemPackages = with pkgs; [ 
    git 
    neovim
    firefox
  ];

  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "no";
  services.openssh.settings.PasswordAuthentication = true;
  services.openssh.settings.KbdInteractiveAuthentication = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.11";

}

