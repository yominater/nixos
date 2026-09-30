{ config, pkgs, lib, inputs, self, ...}:

{ 
  _module.args.device = "inspiron";

  imports = [
    ./hardware.nix

    # shared relatives
    #"${inputs.self}/modules/power-save.nix"
    ];

}

