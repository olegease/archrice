#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
# aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias git-log='git log --oneline'
alias light-set='brightnessctl set'
alias battery-life='cat /sys/class/power_supply/BAT0/capacity'
alias volume-toggle='wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'
alias volume-set='wpctl set-volume @DEFAULT_AUDIO_SINK@'
# switch compiler commands
# -- gcc
function use_gcc( ) {
  export CC=gcc
  export CXX=g++
  echo "Default compiler set to GCC"
}
function use_clang( ) {
  export CC=clang
  export CXX=clang++
  echo "Default compiler set to Clang"
}
# Primary Prompt String: terminal command prompt appearance
PS1=' \[\033[01;36m\]\A\[\033[00m\] \[\033[01;33m\]\W \$\[\033[00m\] '
# home user directory
h="$(echo ~)"
# no default system vscode versions for extension development
alias code-h40="$h/data/vscode/h40/VSCode-linux-x64/bin/code"
alias code-h48="$h/data/vscode/h48/VSCode-linux-x64/bin/code"
alias code-h50="$h/data/vscode/h50/VSCode-linux-x64/bin/code"
alias code-h58="$h/data/vscode/h58/VSCode-linux-x64/bin/code"
alias code-h60="$h/data/vscode/h60/VSCode-linux-x64/bin/code"
alias code-h68="$h/data/vscode/h68/VSCode-linux-x64/bin/code"
alias code-h70="$h/data/vscode/h70/VSCode-linux-x64/bin/code"
alias code-h78="$h/data/vscode/h78/VSCode-linux-x64/bin/code"
# enable running nvm command from command prompt
nvm_script="$h/.nvm/nvm.sh"
[[ -s $nvm_script ]] && source $nvm_script
# path to source code of configurations
export ar_path="$h/code/hub/olegease/archrice"
