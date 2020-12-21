{
  outputs = { self }: {
    fromDhall = pkgs: path: with pkgs;
      let
        der = stdenv.mkDerivation {
          name = "dhall-to-nix";
          dhall = builtins.toFile "dhall" (builtins.readFile path);
          dontUnpack = true;
          buildInputs = [ dhall-json ];
          installPhase = "dhall-to-json --file $dhall --output $out";
        };
      in
        builtins.fromJSON (builtins.readFile der);
  };
}
