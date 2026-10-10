{ config, pkgs, lib, inputs, self, chaotic, impermanence, ...}:

{ 
  _module.args.device = "thinkpad";

  imports = [
    ./configuration.nix
    ./hardware.nix
    impermanence.nixosModules.impermanence

    # shared relatives
    "${inputs.self}/modules/power-save.nix"
    "${inputs.self}/modules/common.nix"
    "${inputs.self}/modules/environment.nix"
    "${inputs.self}/modules/persistance.nix"
    ];

}
