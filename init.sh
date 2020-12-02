# Personal shell initial file

# ========== Pre check ==========
# avoid init.sh duplicated load
if [ -z "$_INIT_SH_LOADED" ]; then
    _INIT_SH_LOADED=1
else
    return
fi

# return if not running interactively
case "$-" in
    *i*) ;;
    *) return
esac

# common variable
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export BASH_CACHE_DIR=$XDG_CACHE_HOME/bash
if [[ ! -d $BASH_CACHE_DIR ]]; then
    command mkdir -p "$BASH_CACHE_DIR"
fi
export ZSH_CACHE_DIR=$XDG_CACHE_HOME/zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
    command mkdir -p "$ZSH_CACHE_DIR"
fi

# ========== Functions ==========
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
	if [ $RETVAL -ne 0 ]; then
        echo " $RETVAL"
    else
        echo ""
    fi
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

# display shell startup time
timeshell() {
    shell=${1-$SHELL}
    echo "Timing $shell:"
    for i in $(seq 1 5); do /usr/bin/time $shell -i -c exit; done
}

# ========== Prompt ==========
if [ -n "$BASH_VERSION" ]; then
    if [ $UID -eq 0 ]; then
        export PS1=' \[\e[38;5;190m\]λ\[\e[38;5;9m\]$(_retval) \[\e[38;5;51m\]$(_fish_collapsed_pwd)\[\e[38;5;135m\]$(_git_prompt)\[\e[38;5;124m\]#\[\e[0m\] '
    else
        export PS1=' \[\e[38;5;190m\]λ\[\e[38;5;9m\]$(_retval) \[\e[38;5;51m\]$(_fish_collapsed_pwd)\[\e[38;5;135m\]$(_git_prompt)\[\e[38;5;83m\]>\[\e[0m\] '
    fi
else
    if [ $UID -eq 0 ]; then
        export PROMPT='%f %F{190}λ%f%F{9}$(_retval)%f %F{51}$(_fish_collapsed_pwd)%f%F{135}$(_git_prompt)%f%F{124}#%f '
    else
        export PROMPT='%f %F{190}λ%f%F{9}$(_retval)%f %F{51}$(_fish_collapsed_pwd)%f%F{135}$(_git_prompt)%f%F{83}>%f '
    fi
    # export RPROMPT="%F{9}%(?..%?)%f"
fi

# ========== Shell config ==========
# BASH
if [ -n "$BASH_VERSION" ]; then
    # -----> options
    shopt -s checkwinsize
    shopt -s extglob
    shopt -s nullglob
    shopt -s nocaseglob
    shopt -s nocasematch

    shopt -u failglob
    if [ "${BASH_VERSINFO:-0}" -ge 4 ]; then
        shopt -s autocd
    fi

    # -----> key bindings
    bind '"\eh": "\C-b"'
	bind '"\el": "\C-f"'
	bind '"\ej": "\C-n"'
	bind '"\ek": "\C-p"'
	bind '"\eH": "\eb"'
	bind '"\eL": "\ef"'
	bind '"\eJ": "\C-a"'
	bind '"\eK": "\C-e"'
	bind '"\e;":"ll\n"'
    bind '"\e[A": history-search-backward'
    bind '"\e[B": history-search-forward'

    # -----> env
    export HISTTIMEFORMAT='%F %T '
    export HISTCONTROL=ignoredups
fi

# ZSH
if [ -n "$ZSH_VERSION" ]; then
    # -----> options
    # general
    setopt COMBINING_CHARS          # Combine zero-length punctuation characters (accents) with the base character.
    setopt EXTENDED_GLOB            # Treat the ‘#’, ‘~’ and ‘^’ characters as part of patterns for filename generation, etc.
    setopt INTERACTIVE_COMMENTS     # Enable comments in interactive shell.
    setopt RC_QUOTES                # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'.
    unsetopt MAIL_WARNING           # Don't print a warning message if a mail file has been accessed.

    # jobs
    setopt LONG_LIST_JOBS           # List jobs in the long format by default.
    setopt AUTO_RESUME              # Attempt to resume existing job before creating a new process.
    setopt NOTIFY                   # Report status of background jobs immediately.
    unsetopt BG_NICE                # Don't run all background jobs at a lower priority.
    unsetopt HUP                    # Don't kill jobs on shell exit.
    unsetopt CHECK_JOBS             # Don't report on jobs when shell exit.

    # completion
    setopt COMPLETE_IN_WORD         # Complete from both ends of a word.
    setopt ALWAYS_TO_END            # Move cursor to the end of a completed word.
    setopt PATH_DIRS                # Perform path search even on command names with slashes.
    setopt AUTO_MENU                # Show completion menu on a successive tab press.
    setopt AUTO_LIST                # Automatically list choices on ambiguous completion.
    setopt AUTO_PARAM_SLASH         # If completed parameter is a directory, add a trailing slash.
    unsetopt MENU_COMPLETE          # Do not autoselect the first completion entry.
    unsetopt FLOW_CONTROL           # Disable start/stop characters in shell editor.
    unsetopt CASE_GLOB              # Make globbing (filename generation) sensitive to case.

    # history
    setopt BANG_HIST                # Treat the '!' character specially during expansion.
    setopt EXTENDED_HISTORY         # Write the history file in the ':start:elapsed;command' format.
    setopt SHARE_HISTORY            # Share history between all sessions.
    setopt HIST_EXPIRE_DUPS_FIRST   # Expire a duplicate event first when trimming history.
    setopt HIST_IGNORE_DUPS         # Do not record an event that was just recorded again.
    setopt HIST_IGNORE_ALL_DUPS     # Delete an old recorded event if a new event is a duplicate.
    setopt HIST_FIND_NO_DUPS        # Do not display a previously found event.
    setopt HIST_IGNORE_SPACE        # Do not record an event starting with a space.
    setopt HIST_SAVE_NO_DUPS        # Do not write a duplicate event to the history file.
    setopt HIST_VERIFY              # Do not execute immediately upon history expansion.
    unsetopt HIST_BEEP              # Do not beep when accessing non-existent history.

    # editor
    unsetopt BEEP                   # Do not beep on error in line editor.

    # directory
    setopt AUTO_CD                  # Auto changes to a directory without typing cd.
    setopt AUTO_PUSHD               # Push the old directory onto the stack on cd.
    setopt PUSHD_IGNORE_DUPS        # Do not store duplicates in the stack.
    setopt PUSHD_SILENT             # Do not print the directory stack after pushd or popd.
    setopt PUSHD_TO_HOME            # Push to home directory when no argument is given.
    setopt CDABLE_VARS              # Change directory to a path stored in a variable.
    setopt MULTIOS                  # Write to multiple descriptors.
    unsetopt CLOBBER                # Do not overwrite existing files with > and >>. Use >! and >>! to bypass.

    # prompt
    setopt PROMPT_SUBST             # If set, parameter expansion, command substitution and arithmetic expansion are performed in prompts.

    # setopt append_history           # append history list to the history file.
    # setopt hash_list_all            # whenever a command completion is attempted, make sure the entire command path is hashed first.
    # unsetopt glob_dots              # * shouldn't match dotfiles. ever.
    # unsetopt sh_word_split          # use zsh style word splitting
    # unsetopt nomatch
    # setopt null_glob
    # setopt pushdminus
    # setopt inc_append_history
    # setopt complete_aliases
    # setopt listpacked
    # setopt magic_equal_subst
    # setopt transient_rprompt

    # -----> alias
    alias d='dirs -v'
    for index in $(seq 1 9); do alias "$index"="cd +${index}"; unset index; done

    # -----> completion
    # Load and initialize the completion system ignoring insecure directories with a
    # cache time of 20 hours, so it should almost always regenerate the first time a
    # shell is opened each day.
    autoload -Uz compinit
    _comp_path="$ZSH_CACHE_DIR/zcompdump"
    # #q expands globs in conditional expressions
    # if [[ $_comp_path(#qNmh-20) ]]; then
    #     # -C (skip function check) implies -i (skip security check).
    #     compinit -C -d "$_comp_path"
    # else
    #     command mkdir -p "$_comp_path:h"
    #     compinit -i -d "$_comp_path"
    # fi
    compinit -C -d "$_comp_path"
    unset _comp_path

    # use a cache in order to make completion for commands such as dpkg and apt usable.
    zstyle ':completion::complete:*' use-cache on
    zstyle ':completion::complete:*' cache-path "$ZSH_CACHE_DIR"
    unset _CACHE_DIR

    # case-insensitive (all), partial-word, and then substring completion.
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

    # group matches and describe.
    zstyle ':completion:*:*:*:*:*' menu select
    zstyle ':completion:*:matches' group 'yes'
    zstyle ':completion:*:options' description 'yes'
    zstyle ':completion:*:options' auto-description '%d'
    zstyle ':completion:*:corrections' format ' %F{93}-- %d (errors: %e) --%f'
    zstyle ':completion:*:descriptions' format ' %F{2}-- %d --%f'
    zstyle ':completion:*:messages' format ' %F{8} -- %d --%f'
    zstyle ':completion:*:warnings' format ' %F{9}-- no matches found --%f'
    zstyle ':completion:*:default' list-prompt '%S%M matches%s'
    zstyle ':completion:*' format ' %F{8}-- %d --%f'
    zstyle ':completion:*' group-name ''
    zstyle ':completion:*' verbose yes

    # Fuzzy match mistyped completions.
    zstyle ':completion:*' completer _complete _match _approximate
    zstyle ':completion:*:match:*' original only
    zstyle ':completion:*:approximate:*' max-errors 1 numeric

    # increase the number of errors based on the length of the typed word. But make
    # sure to cap (at 7) the max-errors to avoid hanging.
    zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)'

    # don't complete unavailable commands.
    zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'

    # array completion element sorting.
    zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

    # directories
    zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
    zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
    zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
    zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
    zstyle ':completion:*' squeeze-slashes true

    # history
    zstyle ':completion:*:history-words' stop yes
    zstyle ':completion:*:history-words' remove-all-dups yes
    zstyle ':completion:*:history-words' list false
    zstyle ':completion:*:history-words' menu yes

    # environment variables
    zstyle ':completion::*:(-command-|export):*' fake-parameters ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}

    # hostname
    zstyle -e ':completion:*:hosts' hosts 'reply=(
        ${=${=${=${${(f)"$(cat {/etc/ssh/ssh_,~/.ssh/}known_hosts(|2)(N) 2> /dev/null)"}%%[#| ]*}//\]:[0-9]*/ }//,/ }//\[/ }
        ${=${(f)"$(cat /etc/hosts(|)(N) <<(ypcat hosts 2> /dev/null))"}%%(\#${_etc_host_ignores:+|${(j:|:)~_etc_host_ignores}})*}
        ${=${${${${(@M)${(f)"$(cat ~/.ssh/config 2> /dev/null)"}:#Host *}#Host }:#*\**}:#*\?*}}
    )'

    # don't complete uninteresting users...
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

    # ignore multiple entries.
    zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
    zstyle ':completion:*:rm:*' file-patterns '*:all-files'

    # kill
    zstyle ':completion:*:*:*:*:processes' command 'ps -u $LOGNAME -o pid,user,command -w'
    zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
    zstyle ':completion:*:*:kill:*' menu yes select
    zstyle ':completion:*:*:kill:*' force-list always
    zstyle ':completion:*:*:kill:*' insert-ids single

    # man
    zstyle ':completion:*:manuals' separate-sections true
    zstyle ':completion:*:manuals.(^1*)' insert-sections true

    # ssh/scp/rsync
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

    zstyle ':completion:*:cd:*' ignore-parents parent pwd

    # don't complete backup files as executables
    zstyle ':completion:*:complete:-command-::commands' ignored-patterns '(aptitude-*|*\~)'

    # ignore completion functions for commands you don't have:
    zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'

    # search path for sudo completion
    zstyle ':completion:*:sudo:*' command-path /usr/local/sbin \
                                               /usr/local/bin  \
                                               /usr/sbin       \
                                               /usr/bin        \
                                               /sbin           \
                                               /bin

    # -----> key bindings
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

# ========== Variables ==========

# LSCOLORS highlight
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# History
export HISTSIZE=100000
if [ -n "$ZSH_VERSION" ]; then
    export HISTFILE="$ZSH_CACHE_DIR/.zsh_history"
elif [ -n "$BASH_VERSION" ]; then
    export HISTFILE="$BASH_CACHE_DIR/.bash_history"
else
    export HISTFILE="$HOME/.history"
fi
export SAVEHIST=$HISTSIZE

# Editor
export EDITOR='vim'
export VISUAL='vim'
export GIT_EDITOR=$EDITOR

# Shell
export SHELL='/bin/zsh'

# Language
if [[ -z "$LANG" ]]; then
    export LANG=en_US.UTF-8
    export LC_ALL=en_US.UTF-8
fi

# Browser
if [[ "$OSTYPE" == darwin* ]]; then
    export BROWSER='open'
fi

# ~/.local/bin
if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# Golang
# export GO111MODULE=on
if [[ "$OSTYPE" == linux* ]]; then
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
if [[ "$OSTYPE" == darwin* ]]; then
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
if [[ "$OSTYPE" == darwin* ]]; then
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

# ========== Alias ==========
# LS
alias ls='ls -Gh'
alias ll='ls -Ghl'
alias la='ls -aGhl'

# Vim
alias vimrc='vim ~/.vimrc'

# Tmux
alias workbench='tmux new -A -c ~/Workspace/Github -s Workbench'

# Golang
alias gohere='export GOPATH=`pwd`'
alias gobase='export GOPATH=$GOBASEPATH'

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
alias histat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"

# Proxy
http_proxy="127.0.0.1:7890"
socks5_proxy="127.0.0.1:7890"
alias httpproxy="http_proxy=http://$http_proxy https_proxy=http://$http_proxy all_proxy=http://$http_proxy "
alias socks5proxy="http_proxy=socks5://$socks5_proxy https_proxy=socks5://$socks5_proxy all_proxy=socks5://$socks5_proxy "

# Typora
alias typora="open -a typora"

# ========== Scripts ==========
# z.sh
if [ ! -f "$HOME/.local/scripts/z.sh" ]; then
    echo "z.sh doesn't exists."
    echo "Downloading z.sh from github ..."
    echo `curl -fLo ~/.local/scripts/z.sh --create-dirs https://raw.githubusercontent.com/rupa/z/master/z.sh`
fi
. $HOME/.local/scripts/z.sh
export _Z_CMD=z
export _Z_DATA=$XDG_CACHE_HOME/.z

# ========== Tools ==========
# pyenv configuration
# To use Homebrew's directories rather than ~/.pyenv add to your profile:
# export PYENV_ROOT=/usr/local/var/pyenv
# To enable shims and autocompletion add to your profile:
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

# ========== Final ==========
# echo "
# $(tput cuf 25)$(tput setab 1)FBI WARNING$(tput sgr 0)"
# echo "
# $(tput cuf 2)Federal Law provides severe civil and criminal penalties for
# $(tput cuf 2)the unauthorized reproduction, distribution, or exhibition of
# $(tput cuf 2)copyrighted motion pictures (Title 17, United States Code,
# $(tput cuf 2)Sections 501 and 508). The Federal Bureau of Investigation
# $(tput cuf 2)investigates allegations of criminal copyright infringement"
# echo "$(tput cuf 10)(Title 17, United States Code, Section 506)."
# echo ""

# ========== Reference ==========
# https://zhuanlan.zhihu.com/p/50080614
# https://zhuanlan.zhihu.com/p/51008087
# https://wiki.archlinux.org/index.php/zsh
# https://github.com/ohmyzsh/ohmyzsh
# https://github.com/sorin-ionescu/prezto
# https://github.com/rupa/z/blob/master/z.sh
# http://zsh.sourceforge.net/Doc/Release/Options.html#Options
# https://thevaluable.dev/zsh-install-configure/
# https://jonasjacek.github.io/colors/
# https://blog.skk.moe/post/make-oh-my-zsh-fly/
