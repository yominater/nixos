{
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
        set -x EDITOR nvim
      '';
      shellAliases = {
        ll = "ls -l";
        gs = "git status";
        safe-rebuild = "/home/yomi/.scripts/nixos-rebuild.sh";
        safe-home-manager = "/home/yomi/.scripts/home-manager-rebuild.sh";
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

  environment.variables = {
    EDITOR="nvim";
  };
	
}
