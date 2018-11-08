FROM ocaml/opam2:ubuntu-18.04-ocaml-4.06
RUN sudo apt-get -y update && \
  DEBIAN_FRONTEND=noninteractive sudo apt-get -y upgrade && \
  DEBIAN_FRONTEND=noninteractive sudo apt-get -y install neovim python3-pip stow tig zsh && \
  opam repo remove --all default && \
  opam repo add xs-opam https://github.com/edwintorok/xs-opam.git#fixes && \
  opam depext -y xs-toolstack ocp-indent utop merlin && \
  sudo apt-get clean && \
  opam install -j 4 xs-toolstack ocp-indent utop merlin
