FROM ocaml/opam2:ubuntu-18.04-ocaml-4.06
RUN sudo apt-get -y update && \
  DEBIAN_FRONTEND=noninteractive sudo apt-get -y upgrade && \
  DEBIAN_FRONTEND=noninteractive sudo apt-get -y install neovim python3-pip stow tig zsh && \
  opam depext -iy ocp-indent merlin utop ocp-browser ocamlformat && \
  opam repo remove --all default && \
  opam repo add xs-opam https://github.com/xapi-project/xs-opam.git && \
  opam depext -y xs-toolstack && \
  sudo apt-get clean && \
  opam install -j 4 xs-toolstack
