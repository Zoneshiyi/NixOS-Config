{
  pkgs,
  config,
  ...
}:
{
  home.file.".npmrc".text = ''
    prefix = ${config.xdg.dataHome}/npm
  '';
  home.sessionPath = [
    "${config.xdg.dataHome}/npm/bin"
  ];
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
