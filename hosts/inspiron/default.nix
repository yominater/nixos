{ config, pkgs, lib, inputs, self, ...}:

{ 
  _module.args.device = "inspiron";

  imports = [
    ./configuration.nix
    ./hardware.nix

    # shared relatives
    #"${inputs.self}/modules/power-save.nix"
    ];

}

