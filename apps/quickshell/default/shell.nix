with (import <nixpkgs> {});
mkShell {
  buildInputs = [
    qt6.qtdeclarative
  ];
}
