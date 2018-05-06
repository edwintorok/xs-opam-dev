[![](https://images.microbadger.com/badges/image/edwintorok/xs-opam-dev.svg)](https://microbadger.com/images/edwintorok/xs-opam-dev)

Prerequisites:

* docker installed and sudo rights
* `uid` = 1000
* `~/.gitconfig` containing your git `user.name` and `user.email`

To start a development environment:
```
sudo docker run --rm -v ~/.gitconfig:/home/opam/.gitconfig -itv "${PWD}:/local" -w /local edwintorok/xs-opam-dev
```

This contains tools configured as [described here](https://discuss.ocaml.org/t/whats-your-setup-for-ocaml-development/1784/27):

* [NeoVim](https://neovim.io/)
    * [ALE](https://github.com/w0rp/ale.git) for seeing warnings/errors from merlin
    * [Denite](https://github.com/Shougo/denite.nvim) for fuzzy filename search ("Ctrl-P" like), git grep output viewing
    * [deoplete](https://github.com/Shougo/deoplete.nvim.git)+[deoplete-ocaml](https://github.com/copy/deoplete-ocaml.git) for completion and ocamldoc viewing
    * [neoformat](https://github.com/sbdchd/neoformat.git) with [ocp-indent](https://github.com/OCamlPro/ocp-indent) (and experimenting with [ocamlformat](https://github.com/ocaml-ppx/ocamlformat))
    * [lightline](https://github.com/itchyny/lightline.vim)+[vim-fugitive](https://github.com/tpope/vim-fugitive) for status line, [LargeFile](https://github.com/vim-scripts/LargeFile.git) for log files, [gruvbox](https://github.com/morhetz/gruvbox) for colorscheme
* [ripgrep](https://github.com/BurntSushi/ripgrep) for searching
* [tig](https://jonas.github.io/tig/) for exploring git history
* [Z shell](http://www.zsh.org/)
* [git](https://git-scm.com) with [diff-highlight](https://github.com/git/git/tree/master/contrib/diff-highlight), [histogram diff algorithm](https://git-scm.com/docs/git-diff), diff3 conflict style
* [OpenSSH](https://www.openssh.com/) with ControlMaster multiplexing

It does not contain emacs, Visual Studio Code configuration, or tmux.
