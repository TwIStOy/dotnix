let
  availableEnvs = ["default" "tesla"];

  fixModuleName = name:
    if name == "default"
    then "_default.nix"
    else name + ".nix";

  varFor = name: env: let
    envFileName = fixModuleName env;
    filePath = ./${name}/envs/${envFileName};
    defaultPath = ./${name}/envs/_default.nix;
  in
    if builtins.pathExists filePath
    then import filePath
    else import defaultPath;
in rec {
  inherit availableEnvs;

  varsFor = env: {
    user = varFor "user" env;
  };

  allVars = builtins.listToAttrs (
    builtins.map (env: {
      name = env;
      value = varsFor env;
    })
    availableEnvs
  );
}
