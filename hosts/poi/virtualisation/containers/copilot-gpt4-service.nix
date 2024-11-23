{config, ...}: {
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      copilot-gpt4-service = {
        image = "aaamoon/copilot-gpt4-service:latest";
        autoStart = true;
        ports = ["8080:8080"];
        environmentFiles = [
          "${config.age.secrets.copilot-gpt4-service-env.path}"
        ];
      };
    };
  };
}
