# Tarrex's bash/zsh initialization file.

# ============> Prepare <============
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Disable software flow control Ctrl+S (freeze) and Ctrl+Q (restore) in terminal
[[ -x stty ]] && stty -ixon

# XDG base directories specification
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}

# Add /usr/sbin, /usr/local/sbin, ~/.local/bin to PATH
[[ -d /usr/sbin ]]        && export PATH=$PATH:/usr/sbin
[[ -d /usr/local/sbin ]]  && export PATH=$PATH:/usr/local/sbin
[[ -d $HOME/.local/bin ]] && export PATH=$PATH:$HOME/.local/bin

# Dependencies
_check_dependencies() {
    command -v git  >/dev/null 2>&1 && _INSTALLED_GIT=true
    command -v tmux >/dev/null 2>&1 && _INSTALLED_TMUX=true
    command -v fzf  >/dev/null 2>&1 && _INSTALLED_FZF=true
}
_check_dependencies

# Option, leave blank if disable
_ENABLE_Z=true
_ENABLE_GIT_PROMPT=true
_ENABLE_STARSHIP=
_ENABLE_ZINIT=true
_ENABLE_FZF=true

# ============> Script <============
# downloader
_downloader() {
    local url="$1" dest="$2"
    local filename=$(basename "$dest")

    echo "Downloading $filename to $dest ..."
    if command -v curl >/dev/null 2>&1; then
        command curl --connect-timeout 5 --compressed --create-dirs --progress-bar -fLo "$dest" "$url"
    elif command -v wget >/dev/null 2>&1; then
        mkdir -p "$(dirname "$dest")"
        command wget --connect-timeout=5 --compression=auto --quiet --show-progress -O "$dest" "$url"
    else
        echo "Neither curl nor wget is installed" >&2 && return 1
    fi
}

# remove duplicate path
_deduplicate_path() {
    [[ -z $PATH ]] && return 0
    old_PATH=$PATH:; PATH=
    while [[ -n $old_PATH ]]; do
        x=${old_PATH%%:*}
        case $PATH: in
           *:"$x":*) ;;
           *) PATH=$PATH:$x;;
        esac
        old_PATH=${old_PATH#*:}
    done
    PATH=${PATH#:}
    unset old_PATH x
}

# z.sh initialize
_load_z() {
    _Z_HOME=$XDG_DATA_HOME/z
    _Z_SCRIPT=$_Z_HOME/z.sh
    _Z_DATA=$_Z_HOME/zdata
    _Z_SCRIPT_URL=https://raw.githubusercontent.com/rupa/z/master/z.sh

    [[ -f $_Z_SCRIPT ]] || _downloader $_Z_SCRIPT_URL $_Z_SCRIPT
    [[ -f $_Z_DATA ]] || command touch $_Z_DATA 2>/dev/null || echo "z.sh: Failed to created $_Z_DATA" >&2
    [[ -f $_Z_SCRIPT ]] && source $_Z_SCRIPT || echo "z.sh: Failed to source" >&2
}
[[ -n $_ENABLE_Z ]] && [[ -n $ZSH_VERSION || -n $BASH_VERSION ]] && _load_z

# git-prompt.sh initialize
_load_git_prompt() {
    if [[ -f /usr/lib/git-core/git-sh-prompt ]]; then
        source /usr/lib/git-core/git-sh-prompt
        return
    fi
    _GIT_SCRIPT=$XDG_DATA_HOME/git/git-prompt.sh
    _GIT_SCRIPT_URL=https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
    [[ ! -f $_GIT_SCRIPT ]] && _downloader $_GIT_SCRIPT_URL $_GIT_SCRIPT
    [[ -f $_GIT_SCRIPT ]] && source $_GIT_SCRIPT || echo "git-prompt.sh: Failed to source" >&2
}
[[ -n $_INSTALLED_GIT ]] && [[ -n $_ENABLE_GIT_PROMPT ]] && [[ -n $ZSH_VERSION || -n $BASH_VERSION ]] && _load_git_prompt

# ============> Prompt <============
# collapse pwd
_collapsed_pwd() {
    local pwd=${1:-$PWD}
    # early return invalid pwd
    [[ -z "$pwd" || ! -d "$pwd" ]] && return 1
    # handle special paths
    case "$pwd" in
        '/')       printf '/\n' && return ;;
        "$HOME")   printf '~\n' && return ;;
        "$HOME/"*) pwd="~${pwd#$HOME}" ;;
    esac

    # handle special direcotries
    local prefix="^[._-]"
    local elements length
    if [[ -n "$BASH_VERSION" ]]; then
        local IFS="/"
        elements=($pwd)
        length=${#elements[@]}
        for ((i=0;i<length-1;i++)); do
            local elem=${elements[$i]}
            [[ -z ${#elem} ]] && continue
            if [[ ${elem:0:1} =~ $prefix ]]; then
                elements[$i]=${elem:0:2}
            else
                elements[$i]=${elem:0:1}
            fi
        done
    elif [[ -n "$ZSH_VERSION" ]]; then
        elements=("${(s:/:)pwd}")
        length=${#elements}
        for i in {1..$((length-1))}; do
            local elem=${elements[$i]}
            [[ -z ${#elem} ]] && continue
            if [[ ${elem[1]} =~ $prefix ]]; then
                elements[$i]=${elem[1,2]}
            else
                elements[$i]=${elem[1]}
            fi
        done
    else
        printf '%s\n' "$pwd"
    fi

    local IFS="/"
    printf '%s\n' "${elements[*]}"
}

# color codes
declare -A _colors=(
    [success]=39
    [error]=160
    [user]=140
    [root]=202
    [dir]=51
    [branch]=166
    [prompt]=47
    [venv]=152
)

# return value indicator
_retval() {
    local symbol="λ"
    case $LAST_EXIT_CODE in
        0) [[ -n $BASH_VERSION ]] && printf "\e[1;38;5;%sm%s \e[0m" "${_colors[success]}" "${symbol}" && return
           [[ -n $ZSH_VERSION ]] && echo "%F{${_colors[success]}}%B${symbol} %b%f" && return;;
        *) [[ -n $BASH_VERSION ]] && printf "\e[1;38;5;%sm%s \e[0m" "${_colors[error]}" "${symbol}" && return
           [[ -n $ZSH_VERSION ]] && echo "%F{${_colors[error]}}%B${symbol} %b%f" && return;;
    esac
}

# git branch
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_DESCRIBE_STYLE="contains"
GIT_PS1_SHOWUPSTREAM="auto"
_gitbranch() {
    [[ -n $_INSTALLED_GIT && -n $_ENABLE_GIT_PROMPT ]] && echo $(__git_ps1 '[%s]')
}

# python virtual environment
export VIRTUAL_ENV_DISABLE_PROMPT=1
_venv() {
    [[ -n $VIRTUAL_ENV ]] && printf '(%s) ' "${VIRTUAL_ENV##*/}"
}

# prompt setting
_prompt_setting() {
    local newline=$'\n'
    local prompt_end='❯'
    if [[ -n $BASH_VERSION ]]; then
        local user_color="\[\e[1;38;5;${_colors[user]}m\]"
        local dir_color="\[\e[1;38;5;${_colors[dir]}m\]"
        local branch_color="\[\e[38;5;${_colors[branch]}m\]"
        local prompt_color="\[\e[1;38;5;${_colors[prompt]}m\]"
        local venv_color="\[\e[1;38;5;${_colors[venv]}m\]"
        local reset_color="\[\e[0m\]"
        [[ $UID -eq 0 ]] && user_color="\[\e[1;38;5;${_colors[root]}m\]"
        PROMPT_COMMAND='LAST_EXIT_CODE=$?'
        PS1="\$(_retval)"
        PS1+="${venv_color}\$(_venv)${reset_color}"
        PS1+="${user_color}\u@\h${reset_color}: "
        PS1+="${dir_color}\$(_collapsed_pwd) ${branch_color}\$(_gitbranch)${reset_color}"
        PS1+="${newline}"
        PS1+="${prompt_color}${prompt_end}${reset_color} "
    elif [[ -n $ZSH_VERSION ]]; then
        local user_color="%F{${_colors[user]}}"
        local dir_color="%F{${_colors[dir]}}"
        local branch_color="%F{${_colors[branch]}}"
        local prompt_color="%F{${_colors[prompt]}}"
        local venv_color="%F{${_colors[venv]}}"
        local reset_color="%f"
        [[ $UID -eq 0 ]] && user_color="%F{${_colors[root]}}"
        precmd() {
            LAST_EXIT_CODE=$?
        }
        export PROMPT="\$(_retval)"
        PROMPT+="${venv_color}\$(_venv)${reset_color}"
        PROMPT+="${user_color}%B%n@%m%b${reset_color}: "
        PROMPT+="${dir_color}%B\$(_collapsed_pwd)%b${reset_color} ${branch_color}\$(_gitbranch)${reset_color}"
        PROMPT+="${newline}"
        PROMPT+="${prompt_color}%B${prompt_end}%b${reset_color} "
    fi
}
_prompt_setting

# starship
_prompt_starship() {
    command -v starship >/dev/null 2>&1 || return
    export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml
    export STARSHIP_CACHE="$XDG_CACHE_HOME"/starship
    [[ -n $BASH_VERSION ]] && eval "$(starship init bash)" && return
    [[ -n $ZSH_VERSION ]] && eval "$(starship init zsh)" && return
}
[[ -n $_ENABLE_STARSHIP ]] && _prompt_starship

# ============> Shell <============
# bash config
if [[ -n $BASH_VERSION ]]; then
    # -----> Option
    # use `shopt`` to check current options
    # use `shopt -p` to check the special option
    shopt -s autocd
    shopt -s checkjobs
    shopt -s checkwinsize
    shopt -s dotglob
    shopt -s histappend
    shopt -s histreedit
    shopt -s histverify
    shopt -s no_empty_cmd_completion
fi

# zsh config
if [[ -n $ZSH_VERSION ]]; then
    # -----> Option
    # Changing Directories
    setopt AUTO_PUSHD
    setopt PUSHD_IGNORE_DUPS
    setopt PUSHD_SILENT
    # Completion
    setopt COMPLETE_IN_WORD
    unsetopt MENU_COMPLETE
    # Expansion and Globbing
    setopt EXTENDED_GLOB
    # History
    setopt EXTENDED_HISTORY
    setopt HIST_EXPIRE_DUPS_FIRST
    setopt HIST_FIND_NO_DUPS
    setopt HIST_IGNORE_DUPS
    setopt HIST_IGNORE_SPACE
    setopt HIST_REDUCE_BLANKS
    setopt HIST_SAVE_NO_DUPS
    setopt HIST_VERIFY
    setopt INC_APPEND_HISTORY
    setopt HIST_FCNTL_LOCK
    # Input/Output
    setopt INTERACTIVE_COMMENTS
    # Prompting
    setopt PROMPT_SUBST
    setopt TRANSIENT_RPROMPT
    # Zle
    setopt COMBINING_CHARS

    # -----> Environments
    WORDCHARS='*?_[]~=&;!#$%^(){}'

    # -----> Keybindings
    # history search
    autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
    zle -N up-line-or-beginning-search
    zle -N down-line-or-beginning-search
    bindkey '^[[A' up-line-or-beginning-search   # up
    bindkey '^[[B' down-line-or-beginning-search # down

    # Edit the current command line in $EDITOR
    autoload -Uz edit-command-line
    zle -N edit-command-line
    bindkey '\C-x\C-e' edit-command-line

    # -----> Completion
    # Load and initialize the zsh completion system.
    # If use zinit, don't load compinit to avoid compinit duplicate initialization.
    [[ -d $XDG_CACHE_HOME/zsh ]] || command mkdir -p $XDG_CACHE_HOME/zsh
    if [[ ! -f $XDG_DATA_HOME/zinit/bin/zinit.zsh ]]; then
        autoload -Uz compinit
        _comp_path=$XDG_CACHE_HOME/zsh/zcompdump
        if [[ -f $_comp_path ]]; then
            compinit -C -d "$_comp_path" # -C: skip function check
        else
            compinit -i -d "$_comp_path" # -i: skip security check
            # keep $_comp_path younger than cache time even if it isn't regenerated.
            touch "$_comp_path"
        fi
        unset _comp_path
    fi

    # Defaults
    zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
    zstyle ':completion:*:default' list-prompt '%S%M matches%s'

    # Use a cache in order to make completion for commands such as dpkg and apt usable.
    zstyle ':completion::complete:*' use-cache on
    zstyle ':completion::complete:*' cache-path $XDG_CACHE_HOME/zsh/zcompcache

    # Case-insensitive (all), partial-word, and then substring completion.
    zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

    # Group matches and describe.
    zstyle ':completion:*:*:*:*:*' menu select
    zstyle ':completion:*:matches' group 'yes'
    zstyle ':completion:*:options' description 'yes'
    zstyle ':completion:*:options' auto-description '%d'
    zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
    zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
    zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
    zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
    zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
    zstyle ':completion:*' group-name ''
    zstyle ':completion:*' verbose yes
    zstyle ':completion:*' list-separator '  #'

    # Fuzzy match mistyped completions.
    zstyle ':completion:*' completer _complete _match _approximate
    zstyle ':completion:*:match:*' original only
    zstyle ':completion:*:approximate:*' max-errors 1 numeric

    # Increase the number of errors based on the length of the typed word. But make
    # sure to cap (at 7) the max-errors to avoid hanging.
    zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)'

    # Don't complete unavailable commands.
    zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'

    # Array completion element sorting.
    zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

    # Directories
    zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
    zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
    zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
    zstyle ':completion:*' squeeze-slashes true

    # History
    zstyle ':completion:*:history-words' stop yes
    zstyle ':completion:*:history-words' remove-all-dups yes
    zstyle ':completion:*:history-words' list false
    zstyle ':completion:*:history-words' menu yes

    # Environment variables
    zstyle ':completion::*:(-command-|export):*' fake-parameters ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}

    # Hostname
    zstyle -e ':completion:*:hosts' hosts 'reply=(
        ${=${=${=${${(f)"$(cat {/etc/ssh/ssh_,~/.ssh/}known_hosts(|2)(N) 2> /dev/null)"}%%[#| ]*}//\]:[0-9]*/ }//,/ }//\[/ }
        ${=${(f)"$(cat /etc/hosts(|)(N) <<(ypcat hosts 2> /dev/null))"}%%(\#${_etc_host_ignores:+|${(j:|:)~_etc_host_ignores}})*}
        ${=${${${${(@M)${(f)"$(cat ~/.ssh/config ~/.ssh/config.d/* 2> /dev/null)"}:#Host *}#Host }:#*\**}:#*\?*}}
    )'

    # Don't complete uninteresting users...
    zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
        dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
        hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
        mailman mailnull mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
        operator pcap postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs '_*'

    # ... unless we really want to.
    zstyle '*' single-ignored show

    # Ignore multiple entries.
    zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
    zstyle ':completion:*:rm:*' file-patterns '*:all-files'

    # Kill
    zstyle ':completion:*:*:*:*:processes' command 'ps -u $LOGNAME -o pid,user,command -w'
    zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
    zstyle ':completion:*:*:kill:*' menu yes select
    zstyle ':completion:*:*:kill:*' force-list always
    zstyle ':completion:*:*:kill:*' insert-ids single

    # Man
    zstyle ':completion:*:manuals' separate-sections true
    zstyle ':completion:*:manuals.(^1*)' insert-sections true

    # SSH/SCP/RSYNC
    zstyle ':completion:*:(ssh|scp|rsync):*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
    zstyle ':completion:*:(scp|rsync):*' group-order users files all-files hosts-domain hosts-host hosts-ipaddr
    zstyle ':completion:*:ssh:*' group-order users hosts-domain hosts-host users hosts-ipaddr
    zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
    zstyle ':completion:*:(ssh|scp|rsync):*:hosts-domain' ignored-patterns '<->.<->.<->.<->' '^[-[:alnum:]]##(.[-[:alnum:]]##)##' '*@*'
    zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'

    zstyle ':completion:*' rehash true
    zstyle ':completion:*' special-dirs ..

    # start menu completion only if it could find no unambiguous initial string
    zstyle ':completion:*:correct:*' insert-unambiguous true
    zstyle ':completion:*:correct:*' original true

    # search path for sudo completion
    zstyle ':completion:*:sudo:*' command-path /usr/local/sbin \
                                               /usr/local/bin  \
                                               /usr/sbin       \
                                               /usr/bin        \
                                               /sbin           \
                                               /bin

    # -----> Plugin
    # zinit
    if [[ -n $_INSTALLED_GIT && -n $_ENABLE_ZINIT ]]; then
        typeset -A ZINIT=(
            HOME_DIR        $XDG_DATA_HOME/zinit
            ZCOMPDUMP_PATH  $XDG_CACHE_HOME/zsh/zcompdump
            COMPINIT_OPTS   -C
        )

        # zinit install
        [[ -d $ZINIT[HOME_DIR] ]] || command mkdir -p $ZINIT[HOME_DIR]
        if [[ ! -f $ZINIT[HOME_DIR]/bin/zinit.zsh ]]; then
            command git clone --depth 1 https://github.com/zdharma-continuum/zinit.git $ZINIT[HOME_DIR]/bin
        fi

        # initial
        if [[ -f $ZINIT[HOME_DIR]/bin/zinit.zsh ]]; then
            source $ZINIT[HOME_DIR]/bin/zinit.zsh

            # zinit compinit
            autoload -Uz _zinit
            (( ${+_comps} )) && _comps[zinit]=_zinit

            # zinit plugin
            zinit ice wait lucid atinit'zpcompinit; zpcdreplay' depth'1' id-as'zsh-syntax-highlighting'
            zinit light zsh-users/zsh-syntax-highlighting

            zinit ice wait lucid atload'_zsh_autosuggest_start' depth'1' id-as'zsh-autosuggestions'
            zinit light zsh-users/zsh-autosuggestions

            zinit ice wait lucid blockf depth'1' id-as'zsh-completions'
            zinit light zsh-users/zsh-completions

            zinit ice lucid depth'1' id-as'history-search-multi-word'
            zinit light zdharma-continuum/history-search-multi-word

            zinit ice wait silent nocompile has'docker' as'completion' id-as'docker-completion' \
                atclone'docker completion zsh > _docker' atpull'%atclone'
            zinit load zdharma-continuum/null

            zinit ice wait silent nocompile has'kubectl' as'completion' id-as'kubectl-completion' \
                atclone'kubectl completion zsh > _kubectl' atpull'%atclone'
            zinit load zdharma-continuum/null

            zinit ice wait silent nocompile has'helm' as'completion' id-as'helm-completion' \
                atclone'helm completion zsh > _helm' atpull'%atclone'
            zinit load zdharma-continuum/null
        fi
    fi

    # -----> Command-not-found
    [[ -r /etc/zsh_command_not_found ]] && source /etc/zsh_command_not_found
fi

# ============> Custom <============
# history
if [[ -n $BASH_VERSION ]]; then
    export HISTSIZE=10000000
    export HISTFILESIZE=10000001
    # export HISTCONTROL=ignoreboth
    export HISTIGNORE='ls:ll:la:ls -a:ls -l:ls -al:ls -alh:pwd:clear:cd:cd ..:history'
    export HISTFILE=$HOME/.bash_history
elif [[ -n $ZSH_VERSION ]]; then
    export HISTSIZE=10000000
    export SAVEHIST=10000001
    export HISTORY_IGNORE='(ls|ll|la|ls -a|ls -l|ls -al|ls -alh|pwd|clear|cd|cd ..|history)'
    export HISTFILE=$HOME/.zsh_history
fi

# preferred application
export PAGER='less'
export EDITOR='vim'
export VISUAL='vim'
[[ $OSTYPE == darwin* ]] && export BROWSER='open'

# language
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# timezone
export TZ='Asia/Shanghai'

# less
export LESS='-g -i -M -R -S -w -z-4'
export LESSCHARSET=utf-8
export LESSHISTFILE=-
export LESS_TERMCAP_mb=$'\E[01;31m'      # begins blinking.
export LESS_TERMCAP_md=$'\E[01;31m'      # begins bold.
export LESS_TERMCAP_me=$'\E[0m'          # ends mode.
export LESS_TERMCAP_se=$'\E[0m'          # ends standout-mode.
export LESS_TERMCAP_so=$'\E[00;47;30m'   # begins standout-mode.
export LESS_TERMCAP_ue=$'\E[0m'          # ends underline.
export LESS_TERMCAP_us=$'\E[01;32m'      # begins underline.
# lesspipe
[[ -x /usr/bin/lesspipe ]] && eval "$(lesspipe)"

# man
# limit man display width
# export MANWIDTH=90
# use vim for man pager
# command -v vim >/dev/null 2>&1 && export MANPAGER="vim -M +MANPAGER --not-a-term -"

# ls colors highlight
if [[ $OSTYPE == darwin* || $OSTYPE == *bsd* ]]; then
    # export LSCOLORS=${LSCOLORS:-'exfxcxdxbxGxDxabagacad'}
    export LSCOLORS=${LSCOLORS:-'Gxfxcxdxbxegedabagacad'}
else
    # export LS_COLORS=${LS_COLORS:-'di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'}
    export LS_COLORS=${LS_COLORS:-'bd=38;5;68:ca=38;5;17:cd=38;5;113;1:di=38;5;30:do=38;5;127:ex=38;5;208;1:pi=38;5;126:fi=0:ln=target:mh=38;5;222;1:no=0:or=48;5;196;38;5;232;1:ow=38;5;220;1:sg=48;5;3;38;5;0:su=38;5;220;1;3;100;1:so=38;5;197:st=38;5;86;48;5;234:tw=48;5;235;38;5;139;3'}
fi

# nvim
[[ -d $HOME/.local/nvim ]] && export PATH=$PATH:$HOME/.local/nvim/bin

# homebrew
if [[ $OSTYPE == darwin* ]]; then
    export HOMEBREW_PREFIX=$([[ $(uname -m) == arm64 ]] && echo /opt/homebrew || echo /usr/local)
    export HOMEBREW_NO_ANALYTICS=1
    export HOMEBREW_NO_AUTO_UPDATE=1
    eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
fi

# golang
export GOBASEPATH=$HOME/projects/go
case $OSTYPE in
    darwin*) export GOROOT=$HOMEBREW_PREFIX/opt/go/libexec;;
     linux*) export GOROOT=/usr/local/go;;
esac
export GO111MODULE=on
export GOPATH=$GOBASEPATH
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export GOMODCACHE=$GOPATH/pkg/mod           # default, go clean -modcache
export GOCACHE=$XDG_CACHE_HOME/go-build     # go clean -cache
export GOLANGCI_LINT_CACHE=$XDG_CACHE_HOME/golangci-lint
# export GOPROXY=https://goproxy.cn,direct
# export GOSUMDB=sum.golang.google.cn

alias gohere='export GOPATH=`pwd`'
alias gobase='export GOPATH=$GOBASEPATH'

# rust
export RUSTUP_HOME=$XDG_DATA_HOME/rustup
case $OSTYPE in
    darwin*) export RUST_TOOLCHAIN=stable-x86_64-apple-darwin;;
     linux*) export RUST_TOOLCHAIN=stable-x86_64-unknown-linux-gnu;;
esac
export RUSTUP_DIST_SERVER=https://static.rust-lang.org
export RUSTUP_UPDATE_ROOT=https://static.rust-lang.org/rustup
export CARGO_HOME=$XDG_DATA_HOME/cargo
export PATH=$PATH:$CARGO_HOME/bin

# python
export PYTHONSTARTUP=$XDG_CONFIG_HOME/python/startup.py
alias pyhere='export PYTHONPATH=`pwd`'

# node / npm
export NODE_REPL_HISTORY=-
if [[ -d $HOME/.local/node ]]; then
    export PATH=$PATH:$HOME/.local/node/bin
elif [[ -d /usr/local/node ]]; then
    export PATH=$PATH:/usr/local/node/bin
fi

# orbstack
export PATH=$PATH:$HOME/.orbstack/bin

# wakatime
export WAKATIME_HOME=$XDG_CONFIG_HOME/wakatime

# fzf
if [[ -n $_ENABLE_FZF && -n $_INSTALLED_FZF ]]; then
    export FZF_COMPLETION_TRIGGER='~~'
    export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --height 40%
    --reverse
    --bind "ctrl-f:preview-page-down,ctrl-b:preview-page-up"
    --color=light
    --color=fg:-1,bg:-1,hl+:#ffaf5f
    --color=fg+:-1,bg+:-1,hl+:#ffaf5f
    --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7
    --color=marker:#ff87d7,spinner:#ff87d7,header:#af87ff
    '

    if [[ -n $_INSTALLED_TMUX ]]; then
        # tm - create new tmux session, or switch to existing one
        tm() {
            [[ -n $TMUX ]] && cmd='switchc' || cmd='attach'
            if [[ -n $1 ]]; then
                tmux $cmd -t $1 2>/dev/null || (tmux new -d -s $1 && tmux $cmd -t $1); return
            fi

            tmux ls -F '#S' 2>/dev/null | fzf --bind=enter:replace-query+print-query |
                read session &&
                tmux $cmd -t $session 2>/dev/null ||
                (tmux new -d -s ${session} 2>/dev/null && tmux $cmd -t ${session} 2>/dev/null) ||
                return 0
        }

        # tp - switch tmux pane
        tp() {
            local panes current_window current_pane target target_window target_pane
            panes=$(tmux list-panes -s -F '#I:#P - #{pane_current_path} #{pane_current_command}')
            current_pane=$(tmux display-message -p '#I:#P')
            current_window=$(tmux display-message -p '#I')

            target=$(echo "$panes" | grep -v "$current_pane" | fzf +m --reverse) || return

            target_window=$(echo $target | awk 'BEGIN{FS=":|-"} {print$1}')
            target_pane=$(echo $target | awk 'BEGIN{FS=":|-"} {print$2}' | cut -c 1)

            if [[ $current_window -eq $target_window ]]; then
                tmux select-pane -t ${target_window}.${target_pane}
            else
                tmux select-pane -t ${target_window}.${target_pane} &&
                tmux select-window -t $target_window
            fi
        }
    fi

    if [[ -n $_INSTALLED_GIT ]]; then
        # gdiff - broser git diff files
        gdiff() {
            ! command git rev-parse --is-inside-work-tree >/dev/null 2>&1 && echo "Not a git repository" && return
            preview="git diff $@ --color=always -- {-1}" #TODO: fix not root file preview
            git diff $@ --name-only | fzf -m --ansi --preview $preview
        }

        # gcommit - broser git commit history
        gcommit() {
            ! command git rev-parse --is-inside-work-tree >/dev/null 2>&1 && echo "Not a git repository" && return
            git log --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"  | \
             fzf --ansi --no-sort --reverse --tiebreak=index --preview \
             'f() { set -- $(echo -- "$@" | grep -o "[a-f0-9]\{7\}"); [ $# -eq 0 ] || git show --color=always $1 ; }; f {}' \
             --bind "j:down,k:up,alt-j:preview-down,alt-k:preview-up,ctrl-f:preview-page-down,ctrl-b:preview-page-up,q:abort,ctrl-m:execute:
                          (grep -o '[a-f0-9]\{7\}' | head -1 |
                          xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                          {}
            FZF-EOF" --preview-window=right:60%
        }
    fi

    if command -v gh >/dev/null 2>&1; then
        ghpr() {
            GH_FORCE_TTY=100% gh pr list \
            | fzf --ansi --preview 'GH_FORCE_TTY=100% gh pr view {+1}' --preview-window right --header-lines 3 \
            | awk '{print $1}' \
            | xargs gh pr checkout
        }

        ghdiff() {
            GH_FORCE_TTY=100% gh pr list \
            | fzf --ansi --preview 'GH_FORCE_TTY=100% gh pr diff --color=always {+1}' --preview-window right --header-lines 3 \
            | awk '{print $1}' \
            | xargs gh pr checkout
        }

        ghissue() {
            GH_FORCE_TTY=100% gh issue list \
            | fzf --ansi --preview 'GH_FORCE_TTY=100% gh issue view {+1}' --preview-window right --header-lines 3 \
            | awk '{print $1}' \
            | xargs gh issue view
        }
    fi
fi

# common alias
case $OSTYPE in
     linux*|cygwin*|msys*) alias ls='ls --color -h';;
    darwin*|*bsd*|FreeBSD) alias ls='ls -Gh';;
esac

if command -v eza >/dev/null 2>&1; then
    alias ll='eza -lF --icons --time-style=long-iso'
    alias la='eza -alF --icons --time-style=long-iso'
else
    alias ll='ls -l'
    alias la='ll -a'
fi

alias grep='grep --color=auto'
alias fgrep='grep -F --color=auto'
alias egrep='grep -E --color=auto'

alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias mkdir='mkdir -v'
alias ln='ln -v'

alias dud='du -d 1 -h'
alias duf='du -sh *'
alias job='jobs -l'

alias vi='vim -N -u NONE -i NONE'
alias cdr='cd $(git rev-parse --show-toplevel)'
alias serve='python3 -m http.server 8000'
alias venv='python3 -m venv'
alias lstree="find . -print | sed -e 's;[^/]*/;|---;g;s;---|; |;g'"
alias certexp='_certexp(){openssl s_client -connect $1:443 -servername $1 2> /dev/null | openssl x509 -noout -dates};_certexp'
alias randstr='openssl rand -base64 32'
alias weather='_weather(){curl -H "Accept-Language: ${LANG%_*}" --compressed v2.wttr.in/${1-Beijing}};_weather'
alias cheat='_cheat(){curl cheat.sh/$1};_cheat'
alias dict='_dict(){local word="$1"; local dict="${2:-gcide}"; curl -s "dict://dict.org/d:$word:$dict";};_dict'
alias ipinfo='curl -L wtfismyip.com/yaml'
alias randname='curl -L pseudorandom.name'

# proxy
proxy_addr="127.0.0.1:7890"
no_proxy_addr="localhost,127.0.0.1,127.0.0.0/8,::1,*.local,.local"

alias hproxy="http_proxy=http://$proxy_addr https_proxy=http://$proxy_addr all_proxy=http://$proxy_addr no_proxy=$no_proxy_addr"
alias sproxy="http_proxy=socks5://$proxy_addr https_proxy=socks5://$proxy_addr all_proxy=socks5://$proxy_addr no_proxy=$no_proxy_addr"
alias fly="env http_proxy=http://$proxy_addr https_proxy=http://$proxy_addr all_proxy=http://$proxy_addr"

gfw() {
    if [ -z $http_proxy ]; then
        echo "Enabling proxy: $proxy_addr"
        export http_proxy="http://$proxy_addr"
        export https_proxy="http://$proxy_addr"
        export all_proxy="http://$proxy_addr"
        export no_proxy="$no_proxy_addr"
        echo "You are fucking the GFW!"
    else
        unset http_proxy https_proxy all_proxy no_proxy
        echo "Proxy disabled. Remember fuck the GFW forever!"
    fi
}

pstatus() {
    echo "------ Proxy Status ------"
    echo " HTTP Proxy: ${http_proxy:-Not set}"
    echo "HTTPS Proxy: ${https_proxy:-Not set}"
    echo "  All Proxy: ${all_proxy:-Not set}"
    echo "   No Proxy: ${no_proxy:-Not set}"
    if command -v curl >/dev/null 2>&1; then
        echo -n "External IP: "
        curl -sS --max-time 5 https://wtfismyip.com/text || echo "Failed to get IP"
    fi
    echo "--------------------------"
}

# shell startup time
timeshell() {
    local shell=${1-$SHELL}
    echo "Timing $shell:"
    for i in $(seq 1 5); do time $shell -i -c exit; done
}

# cmd statistics
cmdrank() {
    fc -l 1 \
        | awk '{ CMD[$2]++; count++; } END { for (a in CMD) print CMD[a] " " CMD[a]*100/count "% " a }' \
        | grep -v "./" | sort -nr | head -n20 | column -c3 -s " " -t | nl
}

# ============> Finally <============
_deduplicate_path
