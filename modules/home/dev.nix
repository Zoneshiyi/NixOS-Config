{
  pkgs,
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
    act

    glibc
    libclang
    cmake

    pyright
    isort
    black

    nixd
    nixfmt-rfc-style

    lua-language-server
    stylua

    hyprls

    tree-sitter
    nodejs_24
  ];
}
