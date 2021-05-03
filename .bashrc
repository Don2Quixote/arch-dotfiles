alias cal='cal -m'
alias ls='ls --color=auto'
alias l='ls'
alias ll='ls -lh'
alias lll='ls -lah'
alias del='rmtrash'
alias sqlite3='sqlite3 -box'
alias mariadb='mariadb --auto-vertical-output'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export EDITOR=/usr/bin/vim
export TERM=xterm # SHH working bad if got TERM=xterm-termite

PS1="\[\e[0;32m\][\u\[\e[0m\] \[\e[0;34m\]\W\[\e[0;32m\]]\[\e[0m\] $ "

w() {
    PS1="\[\e[0;32m\][\u\[\e[0m\] \[\e[0;34m\]\w\[\e[0;32m\]]\[\e[0m\] $ "
}

W() {
    PS1="\[\e[0;32m\][\u\[\e[0m\] \[\e[0;34m\]\W\[\e[0;32m\]]\[\e[0m\] $ "
}
