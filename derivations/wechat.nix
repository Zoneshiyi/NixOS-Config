{
  lib,
  appimageTools,
  fetchurl,
}:
let
  version = "4.0.1.11";
  pname = "wechat";
  src = fetchurl {
    url = "https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_x86_64.AppImage";
    hash = "sha256-gBWcNQ1o1AZfNsmu1Vi1Kilqv3YbR+wqOod4XYAeVKo=";
  };
  # appimageContents = appimageTools.extractType1 { inherit pname src; };
in
appimageTools.wrapType2 rec {
  inherit pname version src;
  meta = {
    description = "Messaging app";
    homepage = "https://weixin.qq.com/";
    license = lib.licenses.unfree;
    platforms = [
      "x86_64-linux"
    ];
  };
}
