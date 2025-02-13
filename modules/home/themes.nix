{
  pkgs,
  ...
}:
let
  validKvantumThemes = {
    Catppuccin-Frappe-Flamingo = (
      pkgs.catppuccin.override {
        variant = "frappe";
        accent = "flamingo";
      }
    );
    Catppuccin-Frappe-Sapphire = (
      pkgs.catppuccin.override {
        variant = "frappe";
        accent = "sapphire";
      }
    );
    Catppuccin-Latte-Flamingo = (
      pkgs.catppuccin.override {
        variant = "latte";
        accent = "flamingo";
      }
    );
    Catppuccin-Latte-Sapphire = (
      pkgs.catppuccin.override {
        variant = "latte";
        accent = "sapphire";
      }
    );
    WhiteSur = pkgs.whitesur-kde;
  };
  validGtkThemes = {
    Catppuccin-Latte-gtk = (
      pkgs.catppuccin-gtk.override {
        accents = [
          "blue"
          "flamingo"
          "green"
          "lavender"
          "maroon"
          "mauve"
          "peach"
          "pink"
          "red"
          "rosewater"
          "sapphire"
          "sky"
          "teal"
          "yellow"
        ];
        variant = "latte";
      }
    );
    Catppuccin-Frappe-gtk = (
      pkgs.catppuccin-gtk.override {
        accents = [
          "blue"
          "flamingo"
          "green"
          "lavender"
          "maroon"
          "mauve"
          "peach"
          "pink"
          "red"
          "rosewater"
          "sapphire"
          "sky"
          "teal"
          "yellow"
        ];
        variant = "frappe";
      }
    );
  };
in
{
  home.packages =
    with pkgs;
    [
      whitesur-gtk-theme
      whitesur-kde
      whitesur-icon-theme
      fluent-icon-theme
      whitesur-cursors
      bibata-cursors
      catppuccin-cursors
    ]
    ++ (builtins.attrValues validGtkThemes);

  # gtk = {
  #   enable = true;
  #   theme.name = "catppuccin-latte-flamingo";
  #   iconTheme.name = "WhiteSur";
  # };

  xdg =
    let
      names = builtins.attrNames validKvantumThemes;
    in
    {
      configFile = builtins.listToAttrs (
        builtins.map (name: {
          name = "Kvantum/${name}";
          value = {
            source = "${validKvantumThemes.${name}}/share/Kvantum/${name}";
          };
        }) names
      );
    };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    size = 32;
    package = pkgs.whitesur-cursors;
    name = "WhiteSur-cursors";
  };
  # home.pointerCursor = {
  #   x11.enable = true;
  #   hyprcursor.enable = true;
  #   hyprcursor.size = 50;
  #   package = pkgs.bibata-cursors;
  #   name = "Bibata-Modern-Ice";
  #   package = pkgs.catppuccin-cursors;
  #   name = "catppuccin-frappe-blue-cursors";
  # };
}
