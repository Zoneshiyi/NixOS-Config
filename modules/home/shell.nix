{
  pkgs,
  config,
  configPath,
  mkSymlink,
  inputs,
  ...
}:
let
  funcFiles = builtins.attrNames (builtins.readDir "${configPath}/fish/functions");
in
{
  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "fzf.fish";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
    ];
  };
  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    history = {
      append = true;
      saveNoDups = true;
      share = true;
      path = "${config.xdg.stateHome}/zsh/zsh_history";
    };
    initContent = ''
      source <(fzf --zsh)
      eval "$(zoxide init zsh --cmd cd)"
    '';
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
    enable = true;
    package = inputs.nix-index-database.packages.${pkgs.system}.nix-index-with-db;
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
      "fish/conf.d/zzz-user-init.fish".source =
        mkSymlink "${configPath}/fish/conf.d/zzz-user-init.fish";
    };
}
