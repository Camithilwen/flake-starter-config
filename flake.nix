{
  description = "Nixos config flake";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
	url = "github:nix-community/home-manager";
    	inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
	url = "github:nix-community/nixvim"; # Correct placement of NixVim flake input
	inputs.nixpkgs.follows = "nixpkgs"; # Ensure NixVim follows the same Nixpkgs version
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, nixvim,  ... }: 
    let
	system = "x86_64-linux"; # Specify your system type here
   	pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; }; # Pass inputs to the configuration
      modules = [
        ./hosts/default/configuration.nix
        home-manager.nixosModules.home-manager
	{
		home-manager.useGlobalPkgs = true;
		home-manager.useUserPackages = true;
		home-manager.users.jam = import /etc/nixos/modules/home-manager/home.nix;
		home-manager.extraSpecialArgs = { inherit inputs; };	
	}
      ];
    };

#    homeConfigurations.default = home-manager.lib.homeManagerConfiguration {
#	modules = [
#	 ~/.config/home-manager/home.nix
#	];
#	extraSpecialArgs = { inherit inputs; };
 #   }; 
   
  };
}
