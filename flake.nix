{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable"; # IMPORTANT
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = inputs@{ self, nixpkgs, chaotic, impermanence, ... }: {

    nixosConfigurations =
      let
        username = "yomi";
        mkHost = hostname: path: nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs self username impermanence; };
              modules = [
                path
                {
		  networking.hostName = hostname;
                  nixpkgs.config.allowUnfree = true;
#		  nix.settings.experimental-features = "nix-command flakes";

                  }
	              ./modules/environment.nix
	              ./modules/common.nix
                (./hosts + "/${hostname}" + /configuration.nix)
                (./hosts + "/${hostname}" + /hardware.nix)
              ];
              };
          in
          {
            yomibook = mkHost "yomibook" ./hosts/yomibook;
            inspiron  = mkHost "inspiron"  ./hosts/inspiron;
            thinkpad  = mkHost "thinkpad"  ./hosts/thinkpad;
            desktop   = mkHost "desktop"  ./hosts/desktop;
          };

    };

}




#    nixosConfigurations = {
#      # This should correspond to the hostname of the machine
#      nixos = nixpkgs.lib.nixosSystem { # my hostname
#        system = "x86_64-linux";
#        modules = [
#          ./configuration.nix
#          ./hardware-configuration.nix
#          chaotic.nixosModules.default # IMPORTANT
#          ];
#
#
#      };
