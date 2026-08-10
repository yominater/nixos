{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable"; # IMPORTANT
  };

  outputs = { self, nixpkgs, chaotic, ... }: {

    nixosConfigurations = {
      # This should correspond to the hostname of the machine
      nixos = nixpkgs.lib.nixosSystem { # my hostname
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./hardware-configuration.nix
          chaotic.nixosModules.default # IMPORTANT
	];


      };
    };
  };

}
