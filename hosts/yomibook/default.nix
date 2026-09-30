{ config, pkgs, lib, inputs, self, chaotic, ...}:

{ 
  _module.args.device = "yomibook";

  imports = [
    ./configuration.nix
    ./hardware.nix
    inputs.chaotic.nixosModules.default

    # shared relatives
    "${inputs.self}/modules/power-save.nix"
    ];

}
