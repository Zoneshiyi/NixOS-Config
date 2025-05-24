{
  pkgs,
  lib,
  inputs,
  configPath,
  ...
}:
let
  mkOutOfStoreSymlink =
    path:
    let
      pathStr = toString path;
      name = inputs.home-manager.lib.hm.strings.storeFileName (baseNameOf pathStr);
    in
    pkgs.runCommandLocal name { } ''ln -s ${lib.escapeShellArg pathStr} $out'';
in
{
  environment.etc = {
    "chromium/policies/managed/managed.json".source =
      mkOutOfStoreSymlink "${configPath}/chromium/managed.json";
    "chromium/policies/recommended/recommended.json".source =
      mkOutOfStoreSymlink "${configPath}/chromium/recommended.json";
    "firefox/policies/policies.json".source = 
      mkOutOfStoreSymlink "${configPath}/firefox/policies.json";
  };
}
