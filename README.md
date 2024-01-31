### if using flake to update system navegate to your .dotfiles directory.
```bash
nix flake update
```

### for update the system navegate to your .dotfiles directory.
```bash
sudo nixos-rebuild switch --flake .
```

### for update home-manager navegate to your .dotfiles directory.
```bash
home-manager switch --flake .#nameofthehomeconfiguration
```
