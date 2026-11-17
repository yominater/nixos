{
  environment.persistence."/persistent" = {
    enable = true;  # NB: Defaults to true, not needed
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/flatpak"
      "/var/lib/fwupd"
      "/var/lib/systemd/coredump"
      "/var/lib/systemd/backlight"
      "/var/lib/upower"
      "/var/lib/tailscale"
      "/var/db/sudo/lectured" # for the sudo policy message
      "/etc/NetworkManager/system-connections"
      "/etc/nixos" # for keeping my nixos config intact
      { directory = "/var/lib/colord"; user = "colord"; group = "colord"; mode = "u=rwx,g=rx,o="; }
    ];
    files = [
      "/etc/machine-id"
      { file = "/var/keys/secret_file"; parentDirectory = { mode = "u=rwx,g=,o="; }; }
    ];
    users.root = {
      directories = [
        ".ssh"
        ".config/nvim"
        ".local/share/nvim"
      ];
      };
    users.yomi = {
      directories = [
        "Downloads"
        "Music"
        "Pictures"
        "pictures"
        "images"
        "Documents"
        "Videos"
        "Awesome_vault_2"
        "Projects"
        ".config/obsidian"
        ".config/home-manager"
        ".config/nvim"
        ".config/hypr"
        ".config/sway"
        ".config/niri"
        ".config/waybar"
        ".config/wayle"
        ".config/mozilla"
        ".config/dconf"
        ".config/noctalia"
        ".config/libreoffice"
        ".config/gtk-3.0" # for mouse
        ".config/gtk-4.0" # configuration
        ".config/nix"
        ".mozilla"
        ".cache/nix"
        ".local/share/nvim"
        ".local/share/fish"
        ".local/share/Steam"
        ".local/share/Trash"
        ".steam"
        { directory = ".ssh"; mode = "0700"; }
        { directory = ".nixops"; mode = "0700"; }
        { directory = ".local/share/keyrings"; mode = "0700"; }
        ".local/share/direnv"
      ];
      files = [
#        ".screenrc"
        ".cache/noctalia/shell-state.json"
      ];
    };
  };
}
