{pkgs, ...}: {
  # Only enable either docker or podman -- Not both
  virtualisation = {
    docker = {
      enable = false;
    };

    podman.enable = false;

    libvirtd = {
      enable = true;
    };

    virtualbox.host = {
      enable = false;
      enableExtensionPack = true;
    };
  };

  programs = {
    virt-manager.enable = true;
  };

  systemd.services.systemd-machined = {
    stopIfChanged = false;
    restartIfChanged = false;
  };

  environment.systemPackages = with pkgs; [
    virt-viewer # View Virtual Machines
    #lazydocker
    #docker-client
  ];
}

