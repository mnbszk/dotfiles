if [ $VIM ]; then
    export PS1='\h:\w\$ '
fi

gvim() {
    if [ $# -eq 0 ]; then
        open -a MacVim
    elif [ $# -eq 1 ]; then
        if [ ! -f "$1" ]; then
            touch "$1" || return 1
        fi
        open -a MacVim "$1"
    else
        echo "$@: Invalid arguments"
        return 1
    fi
    return 0
 }

# don't put duplicate lines or lines starging with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
# セッションクローズ時のヒストリファイルへの自動追記
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
# 有効になっている場合、bashはコマンド実行のたびにターミナルのウィンドウサイズを確認して、
# 必要に応じてLINEとCOLUMNの値を更新する
shopt -s checkwinsize

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ls='ls -FG'
alias ll='ls -alFG'
alias la='ls -AG'
alias l='ls -CFG'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here direct.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
