alias ls='ls -FG'
alias ll='ls -alFG'
alias la='ls -AG'
alias l='ls -CFG'

if [ $VIM ]; then
    export PS1='\h:\w\$ '
fi

