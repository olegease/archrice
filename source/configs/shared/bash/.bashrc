#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1=' \[\033[01;36m\]\A\[\033[00m\] \[\033[01;33m\]\W \$\[\033[00m\] '

# home user directory
h="$(echo ~)"
nvm_script="$h/.nvm/nvm.sh"
[[ -s $nvm_script ]] && source $nvm_script

export ar_path="$h/code/hub/olegease/archrice"
