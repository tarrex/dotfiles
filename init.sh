# Personal shell initial file

# avoid duplicated load
if [ -z "$_INIT_SH_LOADED" ]; then
    _INIT_SH_LOADED=1
else
    return
fi

# return if non-interactive shell
case "$-" in
    *i*) ;;
    *) return
esac

# get os
OS=$(command uname -s 2> /dev/null)

# ========== functions ==========
# fish like collapse pwd
function _fish_collapsed_pwd() {
    local pwd="$1"
    local home="$HOME"
    local size=${#home}
    [[ $# == 0 ]] && pwd="$PWD"
    [[ -z "$pwd" ]] && return
    if [[ "$pwd" == "/" ]]; then
        echo "/"
        return
    elif [[ "$pwd" == "$home" ]]; then
        echo "~"
        return
    fi
    [[ "$pwd" == "$home/"* ]] && pwd="~${pwd:$size}"
    if [[ -n "$BASH_VERSION" ]]; then
        local IFS="/"
        local elements=($pwd)
        local length=${#elements[@]}
        for ((i=0;i<length-1;i++)); do
            local elem=${elements[$i]}
            if [[ ${#elem} -gt 1 ]]; then
                elements[$i]=${elem:0:1}
            fi
        done
    else
        local elements=("${(s:/:)pwd}")
        local length=${#elements}
        for i in {1..$((length-1))}; do
            local elem=${elements[$i]}
            if [[ ${#elem} > 1 ]]; then
                elements[$i]=${elem[1]}
            fi
        done
    fi
    local IFS="/"
    echo "${elements[*]}"
}

# get current branch in git repo
function _git_prompt() {
    local ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
    if [[ $? != 0 || $ref == "" ]]; then
        [[ $? == 128 ]] && return
        ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
    fi
    local BRANCH=${ref#refs/heads/}
	if [[ "$BRANCH" != "" ]];then
        local STATUS=$(command git status --short 2>&1 | tee)
        if [[ $STATUS != "" ]]; then
		    echo "($BRANCH*)"
        else
		    echo "($BRANCH)"
        fi
	else
		echo ""
	fi
}

# return value
function _retval() {
	local RETVAL=$?
	[ $RETVAL -ne 0 ] && echo "$RETVAL"
}

# colored man pages
man() {
    env \
        LESS_TERMCAP_mb=$'\e[1;31m' \
        LESS_TERMCAP_md=$'\e[1;31m' \
        LESS_TERMCAP_me=$'\e[0m' \
        LESS_TERMCAP_us=$'\e[1;32m' \
        LESS_TERMCAP_ue=$'\e[0m' \
        LESS_TERMCAP_so=$'\e[1;44;33m' \
        LESS_TERMCAP_se=$'\e[0m' \
        PAGER="${commands[less]:-$PAGER}" \
        command man "$@"
}

# ========== shell options ==========
if [ -n "$BASH_VERSION" ]; then
    if [ $UID -eq 0 ]; then
        export PS1=' \[\e[38;5;51m\]$(_fish_collapsed_pwd)\[\e[38;5;135m\]$(_git_prompt)\[\e[38;5;124m\]#\[\e[0m\] '
    else
        export PS1=' \[\e[38;5;51m\]$(_fish_collapsed_pwd)\[\e[38;5;135m\]$(_git_prompt)\[\e[38;5;83m\]>\[\e[0m\] '
    fi
else
    if [ $UID -eq 0 ]; then
        export PROMPT='%f %F{51}$(_fish_collapsed_pwd)%f%F{135}$(_git_prompt)%f%F{124}#%f '
    else
        export PROMPT='%f %F{51}$(_fish_collapsed_pwd)%f%F{135}$(_git_prompt)%f%F{83}>%f '
    fi
    export RPROMPT="%F{red}%(?..%?)%f"
    # RPROMPT='[%F{yellow}%?%f]'
fi

# BASH
if [ -n "$BASH_VERSION" ]; then
    bind '"\e[A": history-search-backward'
    bind '"\e[B": history-search-forward'

    export HISTCONTROL=ignoredups

    shopt -s checkwinsize
    shopt -s nocasematch
    if [ "${BASH_VERSINFO:-0}" -ge 4 ]; then
        shopt -s autocd
    fi
fi

# ZSH
if [ -n "$ZSH_VERSION" ]; then
    # -----> ZSH options
    setopt append_history           # append history list to the history file.
    setopt share_history            # import new commands from the history file also in other zsh-session.
    setopt extended_history         # save each command's beginning timestamp and the duration to the history file.
    setopt hist_ignore_all_dups     # if a new command line being added to the history list duplicates an older one, the older command is removed from the list.
    setopt hist_ignore_space        # remove command lines from the history list when the first character on the line is a space.
    setopt auto_cd                  # if the command is the name of a directory, perform the cd command to that directory.
    setopt extended_glob            # in order to use #, ~ and ^ for filename generation grep word.
    setopt longlistjobs             # display PID when suspending processes as well.
    setopt notify                   # report the status of backgrounds jobs immediately.
    setopt hash_list_all            # whenever a command completion is attempted, make sure the entire command path is hashed first.
    setopt completeinword           # not just at the end.
    # setopt nohup                    # don't send SIGHUP to background processes when the shell exits.
    setopt auto_pushd               # make cd push the old directory onto the directory stack.
    unsetopt beep                   # avoid beeping.
    setopt pushd_ignore_dups        # don't push the same dir twice.
    unsetopt glob_dots              # * shouldn't match dotfiles. ever.
    unsetopt sh_word_split          # use zsh style word splitting

    setopt hist_expire_dups_first   # delete duplicates first when HISTFILE size exceeds HISTSIZE
    setopt hist_verify              # show command with history expansion to user before running it

    setopt pushdminus

    setopt inc_append_history
    setopt complete_aliases
    setopt multios
    setopt prompt_subst

    setopt listpacked
    setopt magic_equal_subst

    setopt interactive_comments

    setopt transient_rprompt

    # -----> Completion
    autoload -Uz compinit && compinit
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
    zstyle ':completion:*' menu select
    zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
    zstyle ':completion:*' rehash true
    zstyle ':completion:*' special-dirs ..                          # provide .. as a completion


    # current user process pid
    zstyle ':completion:*:processes' command 'ps -afu$USER'
    zstyle ':completion:*:*:*:*:processes' force-list always
    # provide more processes in completion of programs like killall:
    zstyle ':completion:*:processes-names' command 'ps c -u ${USER} -o command | uniq'

    # set format for warnings
    zstyle ':completion:*:warnings' format $'\e[91m -- No Matches Found --\e[0m'
    # set format for completion descriptions
    zstyle ':completion:*:descriptions' format $'\e[2m -- %d --\e[0m'
    # start menu completion only if it could find no unambiguous initial string
    zstyle ':completion:*:correct:*' insert-unambiguous true
    zstyle ':completion:*:correct:*' original true
    zstyle ':completion:*:corrections' format $'\e[93m -- %d (errors: %e) --\e[0m'

    zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
    zstyle ':completion:*:cd:*' ignore-parents parent pwd

    # allow one error for every three characters typed in approximate completer
    zstyle ':completion:*:approximate:'    max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )'

    # don't complete backup files as executables
    zstyle ':completion:*:complete:-command-::commands' ignored-patterns '(aptitude-*|*\~)'

    zstyle ':completion:*:matches'         group 'yes'
    zstyle ':completion:*'                 group-name ''

    zstyle ':completion:*:messages'        format '%d'
    zstyle ':completion:*:options'         auto-description '%d'

    # describe options in full
    zstyle ':completion:*:options'         description 'yes'

    # provide verbose completion information
    zstyle ':completion:*'                 verbose true

    # ignore completion functions for commands you don't have:
    zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'

    # complete manual by their section
    zstyle ':completion:*:manuals'    separate-sections true
    zstyle ':completion:*:manuals.*'  insert-sections   true
    zstyle ':completion:*:man:*'      menu yes select

    # search path for sudo completion
    zstyle ':completion:*:sudo:*' command-path /usr/local/sbin \
                                               /usr/local/bin  \
                                               /usr/sbin       \
                                               /usr/bin        \
                                               /sbin           \
                                               /bin            \
                                               /usr/X11R6/bin


    # some functions, like _apt and _dpkg, are very slow. We can use a cache in order to speed things up
    _CACHE_DIR=$HOME/.cache/zsh
    if [[ ! -d $_CACHE_DIR ]]; then
        command mkdir -p "$_CACHE_DIR"
    fi
    zstyle ':completion:*' use-cache on
    zstyle ':completion:*:complete:*' cache-path "$_CACHE_DIR"
    unset _CACHE_DIR

    # -----> Key bindings
    bindkey -e              # Use Emacs key bindings

    # create a zkbd compatible hash;
    # to add other keys to this hash, see: man 5 terminfo
    typeset -g -A key

    key[Home]="${terminfo[khome]}"
    key[End]="${terminfo[kend]}"
    key[Insert]="${terminfo[kich1]}"
    key[Backspace]="${terminfo[kbs]}"
    key[Delete]="${terminfo[kdch1]}"
    key[Up]="${terminfo[kcuu1]}"
    key[Down]="${terminfo[kcud1]}"
    key[Left]="${terminfo[kcub1]}"
    key[Right]="${terminfo[kcuf1]}"
    key[PageUp]="${terminfo[kpp]}"
    key[PageDown]="${terminfo[knp]}"
    key[Shift-Tab]="${terminfo[kcbt]}"

    # setup key accordingly
    [[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"      beginning-of-line
    [[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"       end-of-line
    [[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"    overwrite-mode
    [[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char
    [[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"    delete-char
    [[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"        up-line-or-history
    [[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"      down-line-or-history
    [[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"      backward-char
    [[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"     forward-char
    [[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"    beginning-of-buffer-or-history
    [[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"  end-of-buffer-or-history
    [[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}" reverse-menu-complete

    # Finally, make sure the terminal is in application mode, when zle is
    # active. Only then are the values from $terminfo valid.
    if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
    	autoload -Uz add-zle-hook-widget
        function zle_application_mode_start() {
            echoti smkx
        }
        function zle_application_mode_stop() {
            echoti rmkx
        }
    	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
    	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
    fi

    # history search
    autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
    zle -N up-line-or-beginning-search
    zle -N down-line-or-beginning-search

    [[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
    [[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

    # Shift, Alt, Ctrl and Meta modifiers
    key[Control-Left]="${terminfo[kLFT5]}"
    key[Control-Right]="${terminfo[kRIT5]}"

    [[ -n "${key[Control-Left]}"  ]] && bindkey -- "${key[Control-Left]}"  backward-word
    [[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}" forward-word

    bindkey '\ew' kill-region                             # [Esc-w] - Kill from the cursor to the mark
    bindkey -s '\el' 'ls\n'                               # [Esc-l] - run command: ls
    bindkey '^r' history-incremental-search-backward      # [Ctrl-r] - Search backward incrementally for a specified string. The string may begin with ^ to anchor the search to the beginning of the line.
    bindkey ' ' magic-space                               # [Space] - do history expansion

    # Edit the current command line in $EDITOR
    autoload -Uz edit-command-line
    zle -N edit-command-line
    bindkey '\C-x\C-e' edit-command-line
fi

# ========== export options ==========

#LSCOLORS
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# History
export HISTSIZE=100000
if [ -n "$ZSH_VERSION" ]; then
    export HISTFILE="$HOME/.zsh_history"
elif [ -n "$BASH_VERSION" ]; then
    export HISTFILE="$HOME/.bash_history"
else
    export HISTFILE="$HOME/.history"
fi
export SAVEHIST=$HISTSIZE

# ENV
export EDITOR='vim'
export GIT_EDITOR='vim'
export SHELL='/bin/zsh'

# Locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# ~/.local/bin
if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# Golang
# export GO111MODULE=on
if [[ $OS == "Linux" ]]; then
    export GOROOT=/usr/local/go
fi
if [ -d "$HOME/Projects/Go" ]; then
    export GOBASEPATH=$HOME/Projects/Go
    export GOPATH=$GOBASEPATH
    export PATH="$GOROOT/bin:$GOBASEPATH/bin:$GOPATH/bin:$PATH"
fi

# Python
export PYTHON_CONFIGURE_OPTS="--enable-framework"

# Brew
if [[ $OS == "Darwin" ]]; then
    export HOMEBREW_NO_ANALYTICS=1
    export HOMEBREW_NO_AUTO_UPDATE=1
    # export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles
    export PATH="/usr/local/sbin:$PATH"
fi

# Rust
export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup
if [ -d "$HOME/.rustup/toolchains/stable-x86_64-apple-darwin" ]; then
    export RUSTUP_HOME="$HOME/.rustup/toolchains/stable-x86_64-apple-darwin"
fi
if [ -d "$HOME/.cargo" ]; then
    export CARGO_HOME="$HOME/.cargo"
    export PATH="$CARGO_HOME/bin:$PATH"
fi

# Java
if [[ $OS == "Darwin" ]]; then
    export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-9.0.4.jdk/Contents/Home"
    export CLASSPATH="$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib/dt.jar"
    export PATH="$JAVA_HOME/bin:$PATH"
fi

# LLVM
if [ -d "/usr/local/opt/llvm/bin" ]; then
    export PATH="/usr/local/opt/llvm/bin:$PATH"
fi

# Other
export PATH="$HOME/Projects/Common/code2ebook:$PATH"


# Remove duplicate path
if [ -n "$PATH" ]; then
    old_PATH=$PATH:; PATH=
    while [ -n "$old_PATH" ]; do
        x=${old_PATH%%:*}
        case $PATH: in
           *:"$x":*) ;;
           *) PATH=$PATH:$x;;
        esac
        old_PATH=${old_PATH#*:}
    done
    PATH=${PATH#:}
    unset old_PATH x
fi
export PATH

# ========== alias options ==========
alias ls='ls -Gh'
alias ll='ls -Ghl'
alias la='ls -aGhl'

alias vimrc='vim ~/.vimrc'

alias workbench='tmux -2 new -A -c ~/Workspace/Github -s Workbench'

alias gohere='export GOPATH=`pwd`'
alias gohome='export GOPATH=$GOBASEPATH'

alias tmux='tmux -2'
alias serve='python3 -m http.server 8000'

# Tools
alias weather='_weather(){curl -H "Accept-Language: ${LANG%_*}" --compressed v2.wttr.in/${1-Beijing}};_weather'
alias cheat='_cheat(){curl cheat.sh/$1};_cheat'
alias dict='_dict(){curl dict://dict.org/d:$1:gcide};_dict'
alias ipinfo='curl wtfismyip.com/json'
alias randname='curl pseudorandom.name'

# Cmd
alias lstree="find . -print | sed -e 's;[^/]*/;|---;g;s;---|; |;g'"
alias cmdrank='history | awk '\''{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}'\'' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n10'

# Proxy
http_proxy="127.0.0.1:7890"
socks5_proxy="127.0.0.1:7890"
alias httpproxy="http_proxy=http://$http_proxy https_proxy=http://$http_proxy all_proxy=http://$http_proxy "
alias socks5proxy="http_proxy=socks5://$socks5_proxy https_proxy=socks5://$socks5_proxy all_proxy=socks5://$socks5_proxy "

# Typora
alias typora="open -a typora"
newDiary() {
    cd ~/Personal/PersonalDiary/diary/$(date +"%Y")/$(date +"%m")
    diary="$(date +'%F').md"
    if [ ! -f $diary ]; then
        touch $diary
    fi
    typora $diary
}
alias diary='newDiary'

# ========== source ==========
if [ -f "$HOME/.local/scripts/z.sh" ]; then
    . $HOME/.local/scripts/z.sh
else
    echo "z.sh doesn't exists."
    echo "Downloading z.sh from github ..."
    echo `curl -fLo ~/.local/scripts/z.sh --create-dirs https://raw.githubusercontent.com/rupa/z/master/z.sh`
fi

# ========== tools configuration ==========
# pyenv configuration
# To use Homebrew's directories rather than ~/.pyenv add to your profile:
# export PYENV_ROOT=/usr/local/var/pyenv
# To enable shims and autocompletion add to your profile:
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

# ========== final process ==========
unset OS
