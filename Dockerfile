FROM xenserver/xs-opam:latest_extra
# without 'yum clean metadata' you get 404 when trying to install any package from epel,
# probably due to installing out of date epel-release
RUN sudo yum clean metadata \
    && sudo yum install -y epel-release \
    && sudo yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo \
    && sudo yum install -y \
        neovim \
        python34-pip \
        ripgrep \
        stow \
        tig \
        zsh \
    && sudo yum clean all \
    && pip3 install --no-cache-dir neovim typing --user
RUN git clone --depth 1 --recursive https://gitlab.com/edwintorok/dotfiles.git ~/dotfiles \
    && rm -rf ~/dotfiles/.git ~/dotfiles/emacs ~/dotfiles/fonts \
    && (cd ~/dotfiles && make install-nogui)
RUN opam remote add upstream https://opam.ocaml.org \
    && opam install -y ocp-indent merlin utop ocp-browser ocamlformat \
    && opam remote remove upstream \
    && rm -rf ~/.opam/archives ~/.opam/packages.dev
ENTRYPOINT ["/usr/bin/zsh", "-l"]
