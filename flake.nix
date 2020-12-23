{
  outputs = { self }: {
    __functor = self: pkgs: path: with pkgs;
      let
        der = runCommand ""
          {
            dhall = path;
            buildInputs = [ dhall-json ];
          }
          "dhall-to-json --file $dhall --output $out";
      in
        builtins.fromJSON (builtins.readFile der);
  };
}
