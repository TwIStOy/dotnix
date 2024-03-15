{
  inputs,
  neon-constants,
}: {
  setHomePackages = value:
    inputs.nixpkgs.lib.attrsets.setAttrByPath
    [
      "users"
      neon-constants.user.name
      "home"
      "packages"
    ]
    value;
}
