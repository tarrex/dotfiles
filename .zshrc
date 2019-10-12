# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="af-magic"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    brew
    cargo
    colored-man-pages
    command-not-found
    common-aliases
    debian
    docker-compose
    docker-machine
    docker
    git
    golang
    iterm2
    node
    osx
    pip
    pyenv
    python
    rand-quote
    tmux
    z
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR=vim

# Golang
export GOBASEPATH=$HOME/workspace/projects/go
export GOPATH=$GOBASEPATH
if [ "$(uname 2> /dev/null)" "==" "Linux" ]; then
    export GOROOT=/usr/local/go
fi
export PATH=$PATH:$GOROOT/bin:$GOBASEPATH/bin:$GOPATH/bin:

# Python
export PYTHON_CONFIGURE_OPTS="--enable-framework"

# Brew
if [ "$(uname 2> /dev/null)" "==" "Darwin" ]; then
    export HOMEBREW_NO_ANALYTICS=1
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias gohere='export GOPATH=`pwd`'
alias gohome='export GOPATH=$GOBASEPATH'
alias tmux='tmux -2'
alias serve='python -m SimpleHTTPServer 8000'
alias weather='_weather(){curl -H "Accept-Language: ${LANG%_*}" --compressed v2.wttr.in/${1-Beijing}};_weather'
alias cinfo='_cinfo(){curl cht.sh/$1};_cinfo'
alias ipinfo='curl ipinfo.io'
alias lstree="find . -print | sed -e 's;[^/]*/;|---;g;s;---|; |;g'"
alias cmdrank='history | awk '\''{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}'\'' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n10'

# set proxy with http_proxy https_proxy or ALL_PROXY by http/https/socks5
# no_proxy will ignore special domains
http_proxy_address="127.0.0.1:7080"
socks5_proxy_address="127.0.0.1:1086"
alias proxybyhttp="export http_proxy=http://$http_proxy_address https_proxy=http://$http_proxy_address"
alias proxybysocks5="export http_proxy=socks5://$socks5_proxy_address https_proxy=socks5://$socks5_proxy_address"
alias unsetproxy="unset http_proxy; unset https_proxy"

# pyenv configuration 
# To use Homebrew's directories rather than ~/.pyenv add to your profile:
# export PYENV_ROOT=/usr/local/var/pyenv
# To enable shims and autocompletion add to your profile:
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi
