{
  pkgs,
  config,
  ...
}:
{
  home.packages = with pkgs; [
    gcc
    gnumake
    (pkgs.python312.withPackages (
      ps: with ps; [
        pynvim
      ]
    ))

    glibc
    libclang
    cmake

    pyright
    isort
    black

    nixd
    nixfmt

    lua-language-server
    stylua

    tree-sitter
    nodejs_24

    fnm
  ];
}
