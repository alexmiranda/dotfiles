with import <nixpkgs> {};
{
  allowUnfree = true;
  allowUnsupportedSystem = true;
  # allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
  #   "teams"
  # ];
}
