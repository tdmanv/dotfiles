#! /bin/bash
#
# dev.sh
# Author tom

set -o errexit
set -o nounset
set -o pipefail
set -o xtrace


main() {
    tmux new -s local -d
    tmux send-keys 'tmux show-buffer | xclip' C-m

    pushd ~/src/ops
    tmux new -s ops -d
    tmux send-keys 'shuf -e pavan pavel hugo onkar shikhar' C-m
    popd

    pushd ~/src/kanister
    tmux new -s kanister -d
    popd

    pushd ~/src/k10
    tmux new -s kasten -d
    tmux send-keys 'cd go/src/kasten.io/k10' C-m
    popd

    pushd ~/Dropbox/kasten/interviews/2021
    tmux new -s interview -d
    popd
}

main $@
