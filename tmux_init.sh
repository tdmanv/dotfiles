#! /bin/bash
#
# tmux_init.sh
# Author tom

set -o errexit
set -o nounset
set -o pipefail
set -o xtrace


main() {
    tmux new -s local -d
    tmux send-keys 'tmux show-buffer | pbcopy'

    pushd ~/dotfiles
    tmux new -s dotfiles -d
    popd

    pushd ~/src/kastenhq/k10
    tmux new -s kasten -d
    tmux send-keys 'cd go/src/kasten.io/k10' C-m
    popd

    pushd ~/src/upstream/kanister
    tmux new -s kanister -d
    popd

    pushd ~/src/ops
    tmux new -s src/ops -d
    tmux send-keys 'shuf -e pavan pavel hugo onkar shikhar' C-m
    popd

    pushd ~/Dropbox/kasten
    tmux new -s dropbox -d
    popd

    pushd ~/src/Veeam-VDC/VDC-SF
    tmux new -s VDC-SF -d
    popd
}

main $@

