{
  pkgs,
  ...
}:
{
  services.syncthing = {
    enable = true;
    package = pkgs.syncthing;
    guiAddress = "127.0.0.1:8384";
  };
  home.packages = with pkgs; [
    qsyncthingtray
  ];
}
