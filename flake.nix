{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim"; # Correct placement of NixVim flake input
    nixvim.inputs.nixpkgs.follows = "nixpkgs"; # Ensure NixVim follows the same Nixpkgs version
  };

  outputs = { self, nixpkgs, home-manager, nixvim, ... } @ inputs: {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux"; # Specify your system type here
      specialArgs = { inherit inputs; }; # Pass inputs to the configuration
      modules = [
        ./hosts/default/configuration.nix,
        home-manager.nixosModules.home-manager,
        nixvim.nixosModules.nixvim, # Using the NixVim module from the flake
        /etc/nixos/modules/nixvim/default.nix # Directly include your existing NixVim config
      ];
    };
  };
}
