{
  inputs,
  neon-constants,
}: {
  # Export configurations to home-manager's scope
  hmConfig = value:
    inputs.nixpkgs.lib.attrsets.setAttrByPath
    [
      "users"
      neon-constants.user.name
    ]
    value;
}
