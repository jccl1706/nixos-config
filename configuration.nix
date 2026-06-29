{ config, lib, pkgs, ... }:

{
  imports = [
      ./hardware-configuration.nix
      ./zsh.nix
      #./gnome.nix
    ];

  # Bootloader
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
    "resume=/dev/disk/by-uuid/6c52488b-173c-4ea4-9d01-39314533612d"
    
    # AMD Framework Power Management Tweaks
    "amdgpu.dcdebugmask=0x10"               # Helps internal components hit deep low-power sleep states
    "amd_pstate=active"                     # Ensures active AMD P-state driver handles core scaling
  ];

  # Networking
  networking.hostName = "framework";
  networking.networkmanager.enable = true;
  
  # X Server & Graphics Stack
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  services.xserver.excludePackages = [ pkgs.xterm ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;                     # Vital for Steam / gaming compatibility layers
  };

  # KDE Plasma Desktop Environment
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Set your time zone
  time.timeZone = "America/New_York";

  # Enable the systemd time synchronization daemon
  services.timesyncd.enable = true;

  # ZSH Shell
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;

  # User Configuration
  users.users.jc = {
     isNormalUser = true;
     extraGroups = [ "networkmanager" "wheel" ];
   };

  # Sudo Rules
  security.sudo.extraRules = [{
     users = [ "jc" ];
     commands = [{ command = "ALL";
     options = [ "NOPASSWD" ];
    }];
  }];

  # Installed Packages
  environment.systemPackages = with pkgs; [ 
    git 
    neovim
    firefox
    fzf
    btop                                    # Monitor CPU scaling and clocks live
    powertop                                # Monitor live battery discharge
  ];

  # SSH Services
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "no";
  services.openssh.settings.PasswordAuthentication = true;
  services.openssh.settings.KbdInteractiveAuthentication = false;

  # Nix & Flake Settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.11";

  # Power & Thermal Management
  services.power-profiles-daemon.enable = lib.mkDefault true;
  services.thermald.enable = true;          # Manages smooth fan curves and temperature regulation
  powerManagement.powertop.enable = true;   # Runs 'powertop --auto-tune' automatically on boot

}
