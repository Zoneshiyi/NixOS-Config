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

    tree-sitter
    nodejs_23
  ];
}
