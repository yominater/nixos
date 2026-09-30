{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable"; # IMPORTANT
  };

  outputs = inputs@{ self, nixpkgs, chaotic, ... }: {

    nixosConfigurations =
      let
        username = "yomi";
        mkHost = hostname: path: nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs self username; };
              modules = [
                path

                {
                  nixpkgs.config.allowUnfree = true;

                  }
              ];
              };
          in
          {
            yomibook = mkHost "yomibook" ./hosts/yomibook;
            inspiron  = mkHost "inspiron"  ./hosts/inspiron;
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
