
export ZSH=$HOME/bin:/usr/local/bin:$PATH

# themes
ZSH_THEME="robbyrussell"

plugins=(git git-flow colored-man-pages common-aliases tmux brew golang python pip node pyenv z)

source $ZSH/oh-my-zsh.sh
