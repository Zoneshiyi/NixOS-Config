{
  lib,
  pkgs,
  config,
  configPath,
  mkSymlink,
  ...
}:
let
  funcFiles = builtins.attrNames (builtins.readDir "${configPath}/fish/functions");
  templatesPath = "${config.home.homeDirectory}/.config/templates";
in
{
  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "fzf.fish";
        src = pkgs.fetchFromGitHub {
          owner = "PatrickF1";
          repo = "fzf.fish";
          rev = "main";
          hash = "sha256-T8KYLA/r/gOKvAivKRoeqIwE2pINlxFQtZJHpOy9GMM=";
        };
      }
    ];
  };
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    history = {
      append = true;
      saveNoDups = true;
      share = true;
      path = "${config.home.homeDirectory}/.local/state/zsh/zsh_history";
    };
    initContent = ''
      source <(fzf --zsh)
      eval "$(zoxide init zsh --cmd cd)"
    '';
    # antidote = {
    #   enable = true;
    #   plugins = [
    #     "zsh-users/zsh-autosuggestions"
    #     "zsh-users/zsh-completions"
    #     "zsh-users/zsh-syntax-highlighting"
    #   ];
    # };
    prezto = {
      enable = true;
      prompt.theme = "adam2";
      pmodules = [
        "autosuggestions"
        "git"
        "syntax-highlighting"
        "environment"
        "terminal"
        "editor"
        "history"
        "directory"
        "spectrum"
        "utility"
        "completion"
        "prompt"
      ];
    };
  };
  programs.nix-index = {
    enableZshIntegration = true;
    enableFishIntegration = true;
  };
  xdg.configFile =
    (builtins.listToAttrs (
      builtins.map (filename: {
        name = "fish/functions/${filename}";
        value = {
          source = mkSymlink "${configPath}/fish/functions/${filename}";
        };
      }) funcFiles
    ))
    // {
      "fish/config.fish" = {
        source = lib.mkForce (mkSymlink "${configPath}/fish/config.fish");
      };
    };
}
