function theme_check
    if test (dconf read /org/gnome/desktop/interface/gtk-theme) = "'catppuccin-latte-flamingo-standard'"
        echo "{ \"text\":\"\", \"tooltip\": \"dark-mode <span color='#ee99a0'>off</span>\", \"class\": \"off\" }"
    else
        echo "{ \"text\":\"\", \"tooltip\": \"dark-mode <span color='#a6da95'>on</span>\", \"class\": \"on\" }"
    end
end