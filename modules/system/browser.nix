{
  pkgs,
  lib,
  inputs,
  configPath,
  mkSymlink,
  ...
}:
{
  environment.etc = {
    "chromium/policies/managed/managed.json".source =
      mkSymlink "${configPath}/chromium/managed.json";
    "chromium/policies/recommended/recommended.json".source =
      mkSymlink "${configPath}/chromium/recommended.json";
    "firefox/policies/policies.json".source = 
      mkSymlink "${configPath}/firefox/policies.json";
  };
}
