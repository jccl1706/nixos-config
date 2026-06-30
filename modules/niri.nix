{ config, pkgs, ... }:

{
  # 1. Enable Niri natively
  programs.niri.enable = true;

  # 2. Add required background daemons
  hardware.bluetooth.enable = true;
  services.upower.enable = true;

  # Add JetBrains Mono
  fonts.packages = with pkgs; [
    jetbrains-mono
  ];

  # --- Add this block here ---
  environment.variables = {
    GTK_ICON_THEME_NAME = "Papirus";
    XCURSOR_THEME = "Adwaita";
  };
  # ---------------------------

  # 3. Install packages
  environment.systemPackages = with pkgs; [
    noctalia-shell
    xwayland-satellite
    papirus-icon-theme
    lxappearance
    alacritty
  ];
}
