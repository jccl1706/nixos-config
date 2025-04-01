{ config, pkgs, ... }:

{
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
}
