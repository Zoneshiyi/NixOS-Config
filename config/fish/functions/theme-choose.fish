function theme-choose
  set ConfigPath ~/NixOS/config
  set waybar $ConfigPath/waybar
  set kitty $ConfigPath/kitty
  set template ~/.config/templates
  set alacritty ~/.config/alacritty/themes/themes
  if test "$argv[1]" = "light"
    dconf write /org/gnome/desktop/interface/gtk-theme "'catppuccin-latte-flamingo-standard'";
    kvantummanager --set "catppuccin-latte-flamingo";
    install -D -m 644 $kitty/latte.conf $template/kitty/style.conf;
    install -D -m 644 $alacritty/catppuccin_latte.toml $template/alacritty/theme.toml;
    echo 'y' | fish_config theme save Tomorrow;
  else
    dconf write /org/gnome/desktop/interface/gtk-theme "'catppuccin-frappe-blue-standard'";
    kvantummanager --set "catppuccin-frappe-sapphire";
    install -D -m 644 $kitty/frappe.conf $template/kitty/style.conf;
    install -D -m 644 $alacritty/catppuccin_frappe.toml $template/alacritty/theme.toml;
    echo 'y' | fish_config theme save Nord;
  end
end