# New contents
if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi
PS1='[\[\e[1;34m\]\t\[\e[m\]]\[\e[1;32m\]\u@\h\[\e[m\]:`__git_ps1`\[\e[1;35m\]\w/\[\e[m\] '
set -o vi
