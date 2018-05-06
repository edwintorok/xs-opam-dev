FROM xenserver/xs-opam:latest_extra
# without 'yum clean metadata' you get 404 when trying to install any package from epel,
# probably due to installing out of date epel-release
RUN sudo yum clean metadata \
    && sudo yum install -y epel-release \
    && sudo yum install -y \
        neovim \
        python34-pip \
        stow \
        tig \
        zsh \
    && sudo yum clean all \
    && pip3 install --no-cache-dir neovim typing --user
RUN git clone --recursive --depth 1 https://gitlab.com/edwintorok/dotfiles.git ~/dotfiles \
    && rm -rf ~/dotfiles/.git ~/dotfiles/emacs ~/dotfiles/fonts \
    && (cd ~/dotfiles && stow *) \
    && nvim -c ':UpdateRemotePlugins' -c ':q'
RUN opam remote add upstream https://opam.ocaml.org \
    && opam install -y ocp-indent merlin utop ocp-browser ocamlformat \
    && opam remote remove upstream \
    && rm -rf ~/.opam/archives ~/.opam/packages.dev
ENTRYPOINT ["/usr/bin/zsh", "-l"]
