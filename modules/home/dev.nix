{
  pkgs,
  ...
}:{
  home.packages = with pkgs; [
    glibc
    libclang

    pyright
    isort
    black

    nixd
    nixfmt-rfc-style

    lua-language-server
    stylua

    hyprls

    tree-sitter
    nodejs_23
  ];
}
