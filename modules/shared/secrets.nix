{
  self,
  pkgs,
  config,
  inputs,
  dotnix-constants,
  ...
}: let
  inherit (inputs) agenix;
  ageSecret = {
    file,
    owner ? "root",
    mode ? "400",
  }: {
    file = "${self}/secrets/${file}";
    inherit owner mode;
  };
  inherit (dotnix-constants) user;
in {
  environment.systemPackages = [
    agenix.packages."${pkgs.system}".default
  ];

  age.identityPaths = [
    "/etc/ssh/ssh_host_ed25519_key"
    "${config.users.users.${user.name}.home}/.ssh/id_ed25519"
  ];

  age.secrets = {
    "frp-server-auth.toml" = ageSecret {
      file = "frp-server-auth.age";
      owner = user.name;
      mode = "777";
    };
    atuin-key = ageSecret {
      file = "atuin-key.age";
      owner = user.name;
    };
    atuin-client-config = ageSecret {
      file = "atuin-client-config.age";
      owner = user.name;
    };
    ssh-remote-host-config = ageSecret {
      file = "ssh-remote-hosts.age";
      owner = user.name;
    };
    copilot-gpt4-service-env = ageSecret {
      file = "copilot-gpt4-service-env.age";
      owner = user.name;
    };
    chatgpt-next-web-env = ageSecret {
      file = "chatgpt-next-web.age";
      owner = user.name;
    };
    github-runners-poi-aaku = ageSecret {
      file = "github-runners-poi-aaku.age";
      owner = user.name;
    };
    wildcard-api-key = ageSecret {
      file = "wildcard-api-key.age";
      owner = user.name;
    };
  };
}
