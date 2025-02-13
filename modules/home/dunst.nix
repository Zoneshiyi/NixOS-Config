{
  pkgs,
  ...
}:
{
  services.dunst = {
    enable = true;
    iconTheme = {
      name = "WhiteSur";
      package = pkgs.whitesur-icon-theme;
    };
    settings = {
      global = {
        frame_color = "#1e66f5";
        separator_color = "frame";
        highlight = "#1e66f5";
        font = "Monospace 11";
        icon_position = "right";
      };
      urgency_low = {
        background = "#eff1f5";
        foreground = "#4c4f69";
      };
      urgency_normal = {
        background = "#eff1f5";
        foreground = "#4c4f69";
        timeout = 10;
      };
      urgency_critical = {
        background = "#eff1f5";
        foreground = "#4c4f69";
        frame_color = "#fe640b";
      };
    };
  };
}
