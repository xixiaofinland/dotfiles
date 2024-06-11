{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  # Specify the shell to be zsh
  shell = "${pkgs.zsh}/bin/zsh";

  buildInputs = [ pkgs.zsh ];

  # Use a zsh login shell and source .zshrc
  shellHook = ''
    if [ -f ~/.zshrc ]; then
      export SHELL=$(which zsh)
      exec $SHELL -l
    fi
  '';
}

