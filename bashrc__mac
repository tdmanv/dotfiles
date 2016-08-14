# some more ls aliases
alias ls='ls -G'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi


# Enables git completion if the file exists.
if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi
PS1='[\[\e[1;34m\]\t\[\e[m\]]\[\e[1;32m\]\u@\h\[\e[m\]:\[\e[1;35m\]\w/\[\e[m\] '
set -o vi
export EDITOR=vim
