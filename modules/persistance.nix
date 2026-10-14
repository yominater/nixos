{
  environment.persistence."/persistent" = {
    enable = true;  # NB: Defaults to true, not needed
    hideMounts = true;
    directories = [
      "/root/.config/nvim"
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/flatpak"
      "/var/lib/fwupd"
      "/var/lib/systemd/coredump"
      "/var/lib/systemd/backlight"
      "/var/lib/upower"
      "/var/lib/tailscale"
      "/etc/NetworkManager/system-connections"
      "/etc/nixos"
      { directory = "/var/lib/colord"; user = "colord"; group = "colord"; mode = "u=rwx,g=rx,o="; }
    ];
    files = [
      "/etc/machine-id"
      { file = "/var/keys/secret_file"; parentDirectory = { mode = "u=rwx,g=,o="; }; }
    ];
    users.yomi = {
      directories = [
        "."
        "Downloads"
        "Music"
        "Pictures"
        "pictures"
        "images"
        "Documents"
        "Videos"
        "Awesome_vault_2"
        ".config/obsidian"
        ".config/home-manager"
        ".config/nvim"
        ".config/hypr"
        ".config/sway"
        ".config/niri"
        ".config/waybar"
        ".config/wayle"
        ".config/mozilla"
        ".mozilla"
        ".config/dconf"
        ".config/noctalia"
        ".config/libreoffice"
        ".cache/nix"
	".local/share/nvim"
	      ".config/nix"
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
        ".screenrc"
        ".cache/noctalia/shell-state.json"
      ];
    };
  };
}
