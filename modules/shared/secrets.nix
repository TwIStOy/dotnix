{
  self,
  pkgs,
  config,
  username,
  agenix,
  ...
}: let
  ageSecret = {
    file,
    owner ? "root",
    mode ? "400",
  }: {
    file = "${self}/secrets/${file}";
    inherit owner mode;
  };
in {
  environment.systemPackages = [
    agenix.packages."${pkgs.system}".default
  ];

  age.identityPaths = [
    "/etc/ssh/ssh_host_ed25519_key"
    "${config.users.users.${username}.home}/.ssh/id_ed25519"
  ];

  age.secrets = {
    "frp-server-auth.toml" = ageSecret {
      file = "frp-server-auth.age";
      owner = username;
      mode = "777";
    };
    atuin-key = ageSecret {
      file = "atuin-key.age";
      owner = username;
    };
    atuin-client-config = ageSecret {
      file = "atuin-client-config.age";
      owner = username;
    };
    ssh-remote-host-config = ageSecret {
      file = "ssh-remote-hosts.age";
      owner = username;
    };
    copilot-gpt4-service-env = ageSecret {
      file = "copilot-gpt4-service-env.age";
      owner = username;
    };
    chatgpt-next-web-env = ageSecret {
      file = "chatgpt-next-web.age";
      owner = username;
    };
  };
}
