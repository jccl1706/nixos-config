{ config, pkgs, ... }:

{
  # Advanced ZSH Configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    
    shellAliases = {
      ll = "ls -l";
      la = "ls -la";
      ".." = "cd ..";
      
      # NixOS quality-of-life shortcuts
      nix-rebuild = "sudo nixos-rebuild boot --flake ~/NixOS/nixos-config/#framework";
      nix-clean = "sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations +3 && nix-store --gc";
    };
  };

  # Enable interactive FZF fuzzy finding keybindings and completions
  programs.fzf = {
    fuzzyCompletion = true;
    keybindings = true;
  };
  # Enable the lightning-fast Starship prompt engine
  programs.starship.enable = true;
}
