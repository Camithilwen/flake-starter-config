{
  description = "NixOS configuration flake";

  inputs = {
    # Define nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    # Home-Manager Input
#    home-manager = {
 #     url = "github:nix-community/home-manager/release-24.11";
  #    inputs.nixpkgs.follows = "nixpkgs";
#    };

    # NixVim Input
#    nixvim = {
 #     url = "github:nix-community/nixvim";
  #    inputs.nixpkgs.follows = "nixpkgs";
  #  };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux"; # Specify your system type
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux"; # Specify your system type again here

        specialArgs = { inherit inputs; }; # Pass inputs to the configuration

        modules = [
          ./hosts/default/configuration.nix
#	({ pkgs, ... }: {
#		environment.systemPackages = with pkgs; [
#			nh
#		];
#		programs.bash.interactiveShellInit = ''
#			switch () { # hostname default for flake output
#				nh os switch --update /etc/nixos/hosts/default ;
#			}
#		'';
#	})	

          # Include Home-Manager
         # home-manager.nixosModules.home-manager {
          #  home-manager.useGlobalPkgs = true;
           # home-manager.useUserPackages = true;
           # home-manager.users.jam = import /etc/nixos/modules/home-manager/home.nix;
           # home-manager.extraSpecialArgs = { inherit inputs; };
         # }
        ];
      };
    };
}

