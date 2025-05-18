{
  pkgs,
  ...
}:
{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    # extraOptions = "";
    daemon.settings = {
      iptables = false;
      log-driver = "json-file";
      log-opts = {
        max-size = "10m";
        max-file = "3";
      };
      proxies = {
        http-proxy = "127.0.0.1:7897";
        https-proxy = "127.0.0.1:7897";
        no-proxy = "localhost,127.0.0.0/8";
      };
      # data-root = "/var/lib/docker";
    };
  };
  users.users.zone.extraGroups = [ "docker" ];
  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}
