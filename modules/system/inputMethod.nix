{
  pkgs,
  ...
}:
{
  environment.variables = {
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
  };
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "zh_CN.UTF-8/UTF-8"
    "zh_CN.GB18030/GB18030"
  ];

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      # fcitx5-gtk
      # fcitx5-qt
      fcitx5-chinese-addons
      fcitx5-rime
      rime-data
      fcitx5-configtool

      fcitx5-nord
    ];
  };
  # i18n.inputMethod.fcitx5.ignoreUserConfig = true; #启用不光个人设置无效，个人词库也会无法保存
  i18n.inputMethod.fcitx5.settings = { };

  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.hack
    nerd-font-patcher
    font-awesome
    noto-fonts
    noto-fonts-color-emoji
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    vistafonts-chs
  ];
  fonts.fontconfig = {
    useEmbeddedBitmaps = true;
    defaultFonts = {
      emoji = [ ];
      monospace = [
        "FiraCode Nerd Font"
        "Noto Sans Mono CJK SC"
      ];
      sansSerif = [
        "DejaVu Sans"
        "Noto Sans CJK SC"
      ];
      serif = [
        "DejaVu Serif"
        "Noto Serif CJK SC"
      ];
    };
  };
}
