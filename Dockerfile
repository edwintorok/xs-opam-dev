FROM xenserver/xs-opam:latest_extra
# without 'yum clean metadata' you get 404 when trying to install any package from epel,
# probably due to installing out of date epel-release
RUN sudo yum clean metadata \
    && sudo yum install -y epel-release
RUN git clone --recursive --depth 1 https://gitlab.com/edwintorok/dotfiles.git /home/opam/dotfiles
RUN sudo yum install -y \
        neovim \
        python34-pip \
        stow \
        tig \
        zsh \
    && pip3 install neovim typing --user
RUN (cd /home/opam/dotfiles\
    && git pull \
    && stow *) \
    && nvim -c ':UpdateRemotePlugins' -c ':q' \
    && opam remote add upstream https://opam.ocaml.org \
    && opam install -y ocp-indent merlin utop ocp-browser ocamlformat \
    && opam remote remove upstream
ENTRYPOINT ["/usr/bin/zsh", "-l"]
