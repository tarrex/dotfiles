# .bashrc

# User specific aliases and functions
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ll='ls -al'
alias l='ls -al'
alias vi='vim'
alias tmux='tmux -2'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi


# Highlight linux man page
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Show command history and time
export HISTTIMEFORMAT='%F %T '
