function theme_toggle
    set ConfigPath ~/NixOS/config
    set waybar $ConfigPath/waybar
    set kitty $ConfigPath/kitty
    set template ~/.config/templates
    set alacritty ~/.config/alacritty/themes/themes
    if test (dconf read /org/gnome/desktop/interface/gtk-theme) = "'catppuccin-latte-flamingo-standard'"
        dconf write /org/gnome/desktop/interface/gtk-theme "'catppuccin-frappe-blue-standard'";
        kvantummanager --set "Catppuccin-Frappe-Sapphire";
        install -D -m 644 $waybar/night.css $template/waybar/style.css;
        install -D -m 644 $kitty/frappe.conf $template/kitty/style.conf;
        install -D -m 644 $alacritty/catppuccin_frappe.toml $template/alacritty/theme.toml;
        echo 'y' | fish_config theme save Nord;
        pkill -SIGUSR2 waybar;
    else
        dconf write /org/gnome/desktop/interface/gtk-theme "'catppuccin-latte-flamingo-standard'";
        kvantummanager --set "Catppuccin-Latte-Flamingo";
        install -D -m 644 $waybar/daytime.css $template/waybar/style.css;
        install -D -m 644 $kitty/latte.conf $template/kitty/style.conf;
        install -D -m 644 $alacritty/catppuccin_latte.toml $template/alacritty/theme.toml;
        echo 'y' | fish_config theme save Tomorrow;
        pkill -SIGUSR2 waybar;
    end
end