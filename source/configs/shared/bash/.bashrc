#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
# exports
export HISTCONTROL="erasedups:ignorespace"
# aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias git-log='git log --oneline'
alias git-local='git -c commit.gpgsign=false'
alias ar-light_set='brightnessctl set'
alias ar-battery_life='cat /sys/class/power_supply/BAT0/capacity'
alias ar-volume_toggle='wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'
alias ar-volume_set='wpctl set-volume @DEFAULT_AUDIO_SINK@'
alias ar-cpu_info='cpupower frequency-info'
alias ar-cpu_save='sudo cpupower frequency-set -g powersave'
alias ar-cpu_perf='sudo cpupower frequency-set -g performance'
alias ar-cpu_util='sudo cpupower frequency-set -g schedutil'
alias ar-sql_start='sudo systemctl start postgresql'
alias ar-sql_stop='sudo systemctl stop postgresql'
alias ar-melody='mpv --no-video --shuffle'
alias ease-git-sync-fork='git pull root main && git push fork main'
alias ease-git-sync-mirror='git push mirror main --tags'
# switch compiler commands
# -- gcc
function ar_use_gcc( ) {
  export CC=gcc
  export CXX=g++
  echo "Default compiler set to GCC"
}
function ar_use_clang( ) {
  export CC=clang
  export CXX=clang++
  echo "Default compiler set to Clang"
}
# Primary Prompt String: terminal command prompt appearance
# -- on failed last command draw dollar sign as red
function ar_set_dollar_color() {
    if [ $? -eq 0 ]; then
        DOLLAR_COLOR="33"
    else
        DOLLAR_COLOR="31"
    fi
}
PROMPT_COMMAND=ar_set_dollar_color
PS1=' \[\033[01;36m\]\A\[\033[00m\] \[\033[01;33m\]\W \[\033[01;${DOLLAR_COLOR}m\]\$\[\033[00m\] '
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
export ar_path="$h/code/ghub/olegease/archrice"

# pnpm
export PNPM_HOME='/home/oleg/.local/share/pnpm'
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end
