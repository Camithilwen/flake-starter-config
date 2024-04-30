{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, nixvim, ... } @ inputs: {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux"; #  Specify your system type here
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/default/configuration.nix
        home-manager.nixosModules.default
        nixvim.nixosModules.nixvim
      ];
    };

   # homeManagerConfigurations = {
    #  jam = home-manager.lib.homeManagerConfiguration {
     #   imports = [
      #    inputs.nixvim.homeManagerModules.nixvim
       # ];
        #home.username = "jam";
       # home.homeDirectory = "/home/jam";
       # system = "x86_64-linux";
        # This should match the NixOS state version or the Home Manager release you're using
       # stateVersion = "23.11";
    #  };
   # };
  };
}
