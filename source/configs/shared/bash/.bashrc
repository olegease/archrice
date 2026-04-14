#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
# aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias git-log='git log --oneline'
# Primary Prompt String: terminal command prompt appearance
PS1=' \[\033[01;36m\]\A\[\033[00m\] \[\033[01;33m\]\W \$\[\033[00m\] '
# home user directory
h="$(echo ~)"
# enable running nvm command from command prompt
nvm_script="$h/.nvm/nvm.sh"
[[ -s $nvm_script ]] && source $nvm_script
# path to source code of configurations
export ar_path="$h/code/hub/olegease/archrice"
