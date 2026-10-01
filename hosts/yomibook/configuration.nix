# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# My NixOs Config

{ config, pkgs, lib, ... }:

let
  #home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz";
in
{
  imports =
    [ # Include the results of the hardware scan.
      #(import "${home-manager}/nixos")
    ];
  # The state version is required and should stay at the version you
  # originally installed.
  #home-manager.useGlobalPkgs = true;
  #home-manager.useUserPackages = true;



    programs.steam = {
      enable = true;
      localNetworkGameTransfers.openFirewall = true;
    };


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_cachyos;

  networking.hostName = "yomibook"; # Define your hostname.

  services.keyd = {
  enable = true;
  keyboards.default = {
    settings = {
      main = {
        leftmeta = "esc";
      };
    };
  };
  }; # keyd

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  services.logind.settings.Login = {
    HandlePowerKey = "ignore";
    HandleLidSwitch = "suspend";
  };


  users.groups.yomi = { };


  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
  # Add these common libs tree-sitter needs
    glibc
    gcc.cc.lib
    zlib
    libffi
    libGL xorg.libX11 xorg.libXrandr
    xorg.libXi libxkbcommon wayland wayland-protocols
  ];

  fonts.packages = with pkgs; [
    ubuntu-sans
    ubuntu-sans-mono
    nerd-fonts.ubuntu
  ];


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  # fonts
    liberation_ttf
    carlito
    gcc
    neovim
    vim
    btop
    lm_sensors
    pciutils
    usbutils
    wget
    tmux
    libnotify
    # import from Yomibok
    alsa-utils
    amd-ucodegen
    baobab
    bc
    bluez-tools
    brightnessctl
    cpio
    eza
    fd
    feh
    fuse2
    fwupd
    inetutils
    luarocks
    mako
    mpv
    pavucontrol
    radeontop
    ranger
    rofi
    sof-firmware
    wl-clipboard
    obsidian
    youtube-tui
    openttd
    waypipe
    playerctl
    (mpv.override {scripts = [mpvScripts.mpris];})
    thunar
    stress-ng
    nmap
    python3
  ];


  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.upower.enable = true;
  services = {
    tailscale.enable = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  networking.hosts = {
    "100.99.228.21" = [ "uptime.home" "immich.home" "uptime.home" ];
  };

  # For Hyprland
  hardware.graphics = {
  enable = true;
  enable32Bit = true;
  };

  zramSwap.enable = true;
  systemd.oomd.enable = true;

  hardware.bluetooth = {
    enable = false;
    powerOnBoot = true;
    settings = {
      General = {
        # Shows battery charge of connected devices on supported
        # Bluetooth adapters. Defaults to 'false'.
        Experimental = true;
        # When enabled other devices can connect faster to us, however
        # the tradeoff is increased power consumption. Defaults to
        # 'false'.
        FastConnectable = true;
      };
      Policy = {
        # Enable all controllers when they are found. This includes
        # adapters present on start as well as adapters that are plugged
        # in later on. Defaults to 'true'.
        AutoEnable = true;
      };
    };
  };

  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  programs.dconf.enable = true;


#  services.journald.extraConfig = [
#    "Storage=volatile\nRuntimeMaxUse=64M"
#    ];


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

  environment.pathsToLink = [ "/share/applications" "/share/xdg-desktop-portal" ];

  nix = {

  # Set core usage
    settings.max-jobs = 1;
    settings.cores = 1;

  # Automatic Garbage Collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w -d";
      persistent = true;
    };

    settings.auto-optimise-store = true;
    settings.experimental-features = "nix-command flakes"; # for home-manager flake

    channel.enable = false;
    };
}

