function theme-choose
  set -l ConfigPath ~/NixOS/config
  set -l kitty $ConfigPath/kitty
  set -l template ~/.config/templates
  set -l alacritty ~/.config/alacritty/themes/themes
  switch $argv[1]
    case "light"
      dconf write /org/gnome/desktop/interface/gtk-theme "'catppuccin-latte-flamingo-standard'";
      kvantummanager --set "catppuccin-latte-flamingo";
      install -D -m 644 $kitty/latte.conf $template/kitty/style.conf;
      install -D -m 644 $alacritty/catppuccin_latte.toml $template/alacritty/theme.toml;
      echo 'y' | fish_config theme save Tomorrow;
    case "dark"
      dconf write /org/gnome/desktop/interface/gtk-theme "'catppuccin-frappe-blue-standard'";
      kvantummanager --set "catppuccin-frappe-sapphire";
      install -D -m 644 $kitty/frappe.conf $template/kitty/style.conf;
      install -D -m 644 $alacritty/catppuccin_frappe.toml $template/alacritty/theme.toml;
      echo 'y' | fish_config theme save Nord;
    case "check"
      if test (dconf read /org/gnome/desktop/interface/gtk-theme) = "'catppuccin-latte-flamingo-standard'"
          echo ""
      else
          echo ""
      end
  end
end