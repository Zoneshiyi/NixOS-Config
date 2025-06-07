{
  pkgs,
  ...
}:
let
  validKvantumThemes = {
    catppuccin-frappe-flamingo = (
      pkgs.catppuccin.override {
        variant = "frappe";
        accent = "flamingo";
      }
    );
    catppuccin-frappe-sapphire = (
      pkgs.catppuccin.override {
        variant = "frappe";
        accent = "sapphire";
      }
    );
    catppuccin-latte-flamingo = (
      pkgs.catppuccin.override {
        variant = "latte";
        accent = "flamingo";
      }
    );
    catppuccin-latte-sapphire = (
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
      rose-pine-cursor
      whitesur-cursors
      bibata-cursors
      capitaine-cursors
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
    enable = true;
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
