{
  pkgs,
  config,
  configPath,
  ...
}:
let
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
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
    policies = {
      DefaultDownloadDirectory = "\${home}/test";
    };
  };
  home.packages = with pkgs; [
    google-chrome
    chromium
  ];
  home.file = {
    ".mozilla/firefox/default/user.js".source = mkSymlink "${configPath}/firefox/user.js";
  };
}
