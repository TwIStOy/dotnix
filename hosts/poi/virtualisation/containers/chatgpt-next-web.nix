{config, ...}: {
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      chatgpt-next-web = {
        image = "yidadaa/chatgpt-next-web:v2.11.3";
        autoStart = true;
        ports = ["3000:3000"];
        environmentFiles = [
          "${config.age.secrets.chatgpt-next-web-env.path}"
        ];
      };
    };
  };
}
