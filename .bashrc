alias ls='ls -FG'
alias ll='ls -alFG'
alias la='ls -AG'
alias l='ls -CFG'

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
