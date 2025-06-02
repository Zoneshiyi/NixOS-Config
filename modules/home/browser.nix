{
  pkgs,
  config,
  configPath,
  mkSymlink,
  ...
}:
{
  xdg.configFile."chromium/External Extensions".source =
    mkSymlink "${configPath}/chromium/extensions";
  programs.firefox = {
    enable = true;
    profiles."default" = {
      id = 0;
      name = "default";
      isDefault = true;
    };
  };
  home.packages = with pkgs; [
    # google-chrome
    chromium
  ];
  home.file = {
    ".mozilla/firefox/default/user.js".source = mkSymlink "${configPath}/firefox/user.js";
  };
}
