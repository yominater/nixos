# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# My NixOs Config

{ config, pkgs, lib, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz";
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (import "${home-manager}/nixos")
    ];
  # The state version is required and should stay at the version you
  # originally installed.
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;


    programs.tmux = {
      enable = true;
      extraConfig = ''
        set -g mouse on
      '';
    };
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
      shellAliases = {
        ll = "ls -l";
        gs = "git status";
        safe-rebuild = "/home/yomi/Scripts/nixos-rebuild.sh";
        safe-home-manager = "/home/yomi/Scripts/home-manager-rebuild.sh";
      };
    };
    programs.git = {
      enable = true;
      config = {
        user.email = "alexandertrains4@gmail.com";
        user.name = "yominater";
        safe.directory = "/etc/nixos";
      };
    };


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_6_19;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "caps:escape_shifted_capslock";
  };

  services.keyd = {
  enable = true;

  keyboards.default = {
    settings = {
      main = {
        leftmeta = "esc";
      };
    };
  };
  };

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
  services.logind.settings.Login.HandlePowerKey = "ignore";


  users.groups.yomi = { };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.yomi = {
    isNormalUser = true;
    description = "NixOS";
    extraGroups = [ "networkmanager" "wheel" "yomi"];
    packages = with pkgs; [
      tree-sitter
    ];
    home = "/home/yomi";
    shell = pkgs.fish;
  };

  # Install firefox.
  programs.firefox.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
  # Add these common libs tree-sitter needs
    glibc
    gcc.cc.lib
    zlib
    libffi
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.hack
    ubuntu-sans
    ubuntu-sans-mono
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    gcc
    neovim
    vim
    btop
    wget
    tmux
    fastfetch
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
    ungoogled-chromium
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;



  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };


  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.upower.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # For Hyprland
  hardware.graphics = {
  enable = true;
  enable32Bit = true;
  };

  zramSwap.enable = true;


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

  environment.pathsToLink = [ "/share/applications" "/share/xdg-desktop-portal" ];

  # Set core usage
  nix.settings.max-jobs = 1;
  nix.settings.cores = 3;

  # Automatic Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 1d";

  };
  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = "nix-command flakes"; # for home-manager flake
}

