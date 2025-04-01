{ config, lib, pkgs, ... }:

{
  imports = [
      ./hardware-configuration.nix
      ./gnome.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.kernelModules = [ "amdgpu" ];  
  boot.initrd.systemd.enable = true;
  boot.plymouth.enable = true;
  boot.blacklistedKernelModules = [ "cros_ec_lpcs" ];
  boot.kernelParams = [
    "quiet"
    "splash"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
    "resume=LABEL=NIXOS_SWAP"
  ];

  # Networking
  networking.hostName = "framework";
  networking.networkmanager.enable = true;

  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.excludePackages = [ pkgs.xterm ];

  # ZSH Shell
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  # User
  users.users.jc = {
     isNormalUser = true;
     extraGroups = [ "networkmanager" "wheel" ];
   };

  # Sudo
  security.sudo.extraRules = [{
     users = [ "jc" ];
     commands = [{ command = "ALL";
     options = [ "NOPASSWD" ];
    }];
  }];

  # Packages
  environment.systemPackages = with pkgs; [ 
    git 
    neovim
    firefox
    fzf
  ];

  # SSH Services
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "no";
  services.openssh.settings.PasswordAuthentication = true;
  services.openssh.settings.KbdInteractiveAuthentication = false;

  # Nix & Flake
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.11";

  # Power Profiles
  services.power-profiles-daemon.enable = lib.mkDefault true;

  # Gnome

}


