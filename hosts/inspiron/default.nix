{ config, pkgs, lib, inputs, self, ...}:

{ 
  _module.args.device = "inspiron";

  imports = [

    # shared relatives
    "${inputs.self}/modules/common.nix"
    "${inputs.self}/modules/environment.nix"
    ];

}

