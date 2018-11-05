FROM edwintorok/xs-opam-dev:built
RUN git clone --depth 1 --recursive https://gitlab.com/edwintorok/dotfiles.git ~/dotfiles && \
  rm -rf ~/dotfiles/.git ~/dotfiles/emacs ~/dotfiles/fonts && \
  (cd ~/dotfiles && make install-nogui)
ENTRYPOINT [ "/usr/bin/zsh", "-l" ]
