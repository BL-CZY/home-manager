with (import <nixpkgs> {});
mkShell {
  buildInputs = [
    qt6.qtdeclarative
  ];

  shellHook = ''
    if command -v zsh >/dev/null 2>&1 
    then 
        zsh
    fi 
  '';
}
