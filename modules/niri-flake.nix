{ inputs, ... }: {
  perSystem = { config, self', inputs', pkgs, lib, ... }: {
    
    # 1. Define the custom Niri wrapper
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      settings = {
        # Using self' ensures it pulls the package defined in this same file
        spawn-at-startup = [ (lib.getExe self'.packages.myNoctalia) ];
        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;
        input.keyboard.xkb.layout = "us,ua";
        layout.gaps = 15;
	prefer-no-csd = true;
        
        binds = {
          "Mod+Return".spawn-sh = lib.getExe pkgs.kitty;
          
          # Window Movement
          "Mod+Shift+left".move-column-left = [];
          "Mod+Shift+right".move-column-right = [];
          "Mod+Shift+down".move-window-down = [];
          "Mod+Shift+up".move-window-up = [];

          # Window Focus
          "Mod+left".focus-column-left = [];
          "Mod+right".focus-column-right = [];
          "Mod+down".focus-window-down = [];
          "Mod+up".focus-window-up = [];

          # Close Window
          "Mod+q".close-window = [];

          "Mod+Shift+E".quit = [];
        };
      };
    };

    # 2. Define the Noctalia shell wrapper
    # Ensure 'noctalia.json' exists in the same directory as this file
    packages.myNoctalia = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
      inherit pkgs;
      settings = (builtins.fromJSON (builtins.readFile ./noctalia.json)).settings;
    };
  };

  # 3. Export the module for use in configuration.nix
  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      package = inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };
}
