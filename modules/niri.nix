{ config, pkgs, ... }:

{
  # 1. Enable Niri natively via the NixOS system module
  programs.niri.enable = true;

  # 2. Add required background daemons for Noctalia's bar widgets 
  # (Bluetooth, volume, battery monitoring, and power profiles)
  hardware.bluetooth.enable = true;
  services.upower.enable = true;

  # Add JetBrains Mono to your system font cache
  fonts.packages = with pkgs; [
    jetbrains-mono
  ];

  # 3. Temporarily fetch and install Noctalia Shell
  environment.systemPackages = with pkgs; [
    noctalia-shell
    xwayland-satellite # Allows X11 apps to run natively inside Niri
    papirus-icon-theme
    lxappearance
    alacritty
  ];
}
