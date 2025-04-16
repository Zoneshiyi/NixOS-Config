{
  pkgs,
  ...
}:
{
  xdg.configFile."clangd/config.yaml".text = ''
    CompileFlags:
      Add:
        - "-I${pkgs.libcxx.dev}/include/c++/v1/"
        - "-I${pkgs.glibc.dev}/include/"
        - "-I${pkgs.libclang.lib}/lib/clang/19/include/"
  '';
}
