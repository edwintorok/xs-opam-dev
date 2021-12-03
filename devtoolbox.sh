#!/bin/bash
# using bash to have support for arrays
set -eu

# Which release of Fedora to use for the toolbox
# (recommended to use the latest available)
RELEASE=35

# A (minimal) development environment

declare -a groups=(
    "RPM Development Tools"
    "C Development Tools and Libraries"
    "Development Tools"
)

declare -a packages=(
    "glibc-langpack-en" # by default only C.UTF-8 would be available
    "bash" "zsh" "ncurses-term" # shells & terminals
    "neovim" "python3-neovim" "emacs" # editors
    "stgit" "guilt" "tig" # repo related (git already included)
    "ripgrep" "stow" "jq" "lnav" # utilities
    "rpmlint" # rpm related extra
    "ocaml" "opam" "ansible" # language specific
    "krb5-workstation" # kerberos
    "man" "man-pages" "pandoc" # documentation
    "blktrace" "bpftrace" "gnuplot" "wireshark-cli" "kernel-tools" # perf related
    "python3-mypy" "clang-analyzer" "ShellCheck" "clang-tools-extra" # static analysis/linting
)

# Customizable names

REGISTRY="registry.fedoraproject.org"
CONTAINER="fedora-toolbox-dev-${USER}"
IMAGE="${REGISTRY}/fedora-toolbox:${RELEASE}"

# Build a mutable persistent container

toolbox()
{
    .toolbox/toolbox --image "${IMAGE}" --container "${CONTAINER}" -u -- "$@"
}

# Normally we'd avoid storing the dnf cache in a container
# But this is a long-lived/persistent container, so having the cache is useful
# (dnf makecache can be quite slow)
#toolbox sudo dnf makecache
toolbox sudo dnf install -y "${packages[@]}"
toolbox sudo dnf groupinstall -y "${groups[@]}"

# TODO: NFS on /home doesn't work, move somewhere else and override HOME
# TODO: what about symlinks to /var/tmp from $HOME? (e.g. my .cache...)
