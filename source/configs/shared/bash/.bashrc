#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
# exports
# -- control history
export HISTCONTROL="erasedups:ignorespace"
# -- path to source code of configurations
export ar_path="$HOME/code/ghub/olegease/archrice"
# aliases
alias ar-path="cd $ar_path"
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
alias ar-tree='LC_COLLATE=C tree --filesfirst'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias git-log='git log --oneline'
alias git-local='git -c commit.gpgsign=false'
alias ease-git_sync_fork='git pull root main && git push fork main'
alias ease-git_sync_mirror='git push mirror main --tags'
# -- no default system vscode versions for extension development
alias code-h40="$HOME/data/vscode/h40/VSCode-linux-x64/bin/code"
alias code-h48="$HOME/data/vscode/h48/VSCode-linux-x64/bin/code"
alias code-h50="$HOME/data/vscode/h50/VSCode-linux-x64/bin/code"
alias code-h58="$HOME/data/vscode/h58/VSCode-linux-x64/bin/code"
alias code-h60="$HOME/data/vscode/h60/VSCode-linux-x64/bin/code"
alias code-h68="$HOME/data/vscode/h68/VSCode-linux-x64/bin/code"
alias code-h70="$HOME/data/vscode/h70/VSCode-linux-x64/bin/code"
alias code-h78="$HOME/data/vscode/h78/VSCode-linux-x64/bin/code"
# functions
# -- switch compiler commands
# ---- gcc
function ar-use_gcc( ) {
  export CC=gcc
  export CXX=g++
  echo "Default compiler set to GCC"
}
# ---- clang
function ar-use_clang( ) {
  export CC=clang
  export CXX=clang++
  echo "Default compiler set to Clang"
}
# ---- Regenerate C++ std.pcm for clangd LSP
function ar-clangd_modules23() {
    local stdFlag="-std=c++23"
    local cacheDir="$HOME/.cache/clangd"
    local moduleFile="/usr/share/libc++/v1/std.cppm"
    local outputFile="$cacheDir/std.pcm"

    if [[ ! -f "$moduleFile" ]]; then
        echo "Error: $moduleFile not found." >&2
        echo "Install libc++ first: sudo pacman -S libc++" >&2
        return 1
    fi

    echo "Building std.pcm ($stdFlag) into $outputFile ..."

    if clang++ "$stdFlag" -stdlib=libc++ \
            -Wno-reserved-module-identifier \
            --precompile "$moduleFile" \
            -o "$outputFile"; then
        echo "Done! Clangd std.pcm updated."
    else
        echo "Failed to compile $outputFile" >&2
        return 1
    fi
}
# ---- Primary Prompt String: terminal command prompt appearance
function ar-set_dollar_color() {
    # on failed last command draw dollar sign as red
    if [ $? -eq 0 ]; then
        DOLLAR_COLOR="33"
    else
        DOLLAR_COLOR="31"
    fi
}
PROMPT_COMMAND=ar-set_dollar_color
PS1=' \[\033[01;36m\]\A\[\033[00m\] \[\033[01;33m\]\W \[\033[01;${DOLLAR_COLOR}m\]\$\[\033[00m\] '
# AUTO-APPENDED by other tools
# enable running nvm command from command prompt
nvm_script="$HOME/.nvm/nvm.sh"
[[ -s $nvm_script ]] && source $nvm_script
# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end
