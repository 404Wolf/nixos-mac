{config, ...}: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Wolf Mermelstein";
    userEmail = "wolf@404wolf.com";
    delta = {
      enable = true;
      options = {
        decorations = {
          commit-decoration-style = "bold yellow box ul";
          file-decoration-style = "none";
          file-style = "bold yellow ul";
        };
        features = "decorations";
        whitespace-error-style = "22 reverse";
      };
    };
    extraConfig = {
      init = {defaultBranch = "main";};
      global = {
        safe.directory = "*";
        core = {
          excludesfile = "${config.home.homeDirectory}/.config";
        };
      };
    };
  };
  programs.gh = {
    enable = true;
    settings = {git_protocol = "ssh";};
  };
  home.file."${config.home.homeDirectory}/.config/git/ignore".source = ./gitignore;
}
