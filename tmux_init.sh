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
    popd

    pushd ~/src/kanister
    tmux new -s kanister -d
    popd

    pushd ~/src/k10
    tmux new -s kasten -d
    popd

    pushd ~/Documents/interviews
    tmux new -s interviews -d
    popd
}

main $@
