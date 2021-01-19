{
  outputs = { self, nixpkgs }: {
    __functor = _: system: path: with nixpkgs.legacyPackages.${system};
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
