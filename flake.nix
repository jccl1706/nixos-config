{
  description = "Julio's Clean NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } {
    systems = [ "x86_64-linux" ];
    
    # Import your separate Niri logic here
    imports = [ ./modules/niri-flake.nix ];

    flake.nixosConfigurations.framework = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [ ./modules/configuration.nix ];
    };
  };
}
