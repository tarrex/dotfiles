# Tarrex's bash/zsh initialization file.

# ============> Prepare <============
# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# Disable Ctrl+S and Ctrl+Q in terminal
[[ -x stty ]] && stty -ixon

# XDG directories
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# ============> Script <============
# z.sh initialize, comment _Z_CMD if you don't want to use it.
_Z_CMD=z
if [[ -n $_Z_CMD ]]; then
    if [[ ! -f $XDG_DATA_HOME/z/z.sh ]]; then
        echo "$XDG_DATA_HOME/z/z.sh doesn't exists."
        echo "Downloading z.sh from github to $XDG_DATA_HOME/z.sh ..."
        echo `curl --connect-timeout 5 --compressed --create-dirs --progress-bar -fLo \
            $XDG_DATA_HOME/z/z.sh https://raw.githubusercontent.com/rupa/z/master/z.sh`
    fi
    _Z_DATA=$XDG_DATA_HOME/z/zdata
    [[ -f $_Z_DATA ]] || command touch $_Z_DATA
    source $XDG_DATA_HOME/z/z.sh
fi

# git-prompt.sh initialize
if command -v git > /dev/null; then
    if [[ ! -f $XDG_DATA_HOME/git/git-prompt.sh ]]; then
        echo "$XDG_DATA_HOME/git/git-prompt.sh doesn't exiets."
        echo "Downloading git-prompt.sh from github to $XDG_DATA_HOME/git/git-prompt.sh ..."
        echo `curl --connect-timeout 5 --compressed --create-dirs --progress-bar -fLo \
            $XDG_DATA_HOME/git/git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh`
    fi
    source $XDG_DATA_HOME/git/git-prompt.sh
fi

# ============> Prompt <============
# fish like collapse pwd
_fish_collapsed_pwd() {
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
                if [[ ${elem:0:1} == "." || ${elem[1]} == "_" || ${elem[1]} == "-"  ]]; then
                    elements[$i]=${elem:0:2}
                else
                    elements[$i]=${elem:0:1}
                fi
            fi
        done
    else
        local elements=("${(s:/:)pwd}")
        local length=${#elements}
        for i in {1..$((length-1))}; do
            local elem=${elements[$i]}
            if [[ ${#elem} > 1 ]]; then
                if [[ ${elem[1]} == "." || ${elem[1]} == "_" || ${elem[1]} == "-" ]]; then
                    elements[$i]=${elem[1,2]}
                else
                    elements[$i]=${elem[1]}
                fi
            fi
        done
    fi
    local IFS="/"
    echo "${elements[*]}"
}

# return value
_retval() {
    if [[ $? -ne 0 ]]; then
        if [[ -n $BASH_VERSION ]]; then
            echo -e " \033[38;5;9mλ"
        else
            echo "%f %F{9}%Bλ%b%f"
        fi
    else
        if [[ -n $BASH_VERSION ]]; then
            echo -e " \033[38;5;190mλ"
        else
            echo "%f %F{190}%Bλ%b%f"
        fi
    fi
}

# git branch
_gitbranch() {
    if command -v git > /dev/null; then
        echo $(__git_ps1 '(%s)')
    else
        echo ''
    fi
}

if [[ -n $BASH_VERSION ]]; then
    if [[ $UID -eq 0 ]]; then
        export PS1='\[\e[38;5;111m\]\h$(_retval) \[\e[38;5;51m\]$(_fish_collapsed_pwd)\[\e[38;5;135m\]$(_gitbranch)\[\e[38;5;124m\]#\[\e[0m\] '
    else
        export PS1='\[\e[38;5;111m\]\h$(_retval) \[\e[38;5;51m\]$(_fish_collapsed_pwd)\[\e[38;5;135m\]$(_gitbranch)\[\e[38;5;83m\]>\[\e[0m\] '
    fi
else
    if [[ $UID -eq 0 ]]; then
        export PROMPT='%f%F{111}%m$(_retval) %F{51}$(_fish_collapsed_pwd)%f%F{135}$(_gitbranch)%f%F{124}#%f '
    else
        export PROMPT='%f%F{111}%m$(_retval) %F{51}$(_fish_collapsed_pwd)%f%F{135}$(_gitbranch)%f%F{83}>%f '
    fi
fi

# ============> Shell <============
# BASH
if [[ -n $BASH_VERSION ]]; then
    # -----> Option
    if [[ ${BASH_VERSINFO:-0} -ge 4 ]]; then
        shopt -s autocd     # A command name that is a directory name is executed as if it were the cd command's argument.
        shopt -s checkjobs  # Lists the status of any stopped and running jobs before exiting an interactive shell.
    fi
    shopt -s checkwinsize   # Checks the window size of the current terminal window after each command, and, if necessary, updates the values of the LINES and COLUMNS shell variables.
    shopt -s histappend     # Append to the history file, don't overwrite it
    shopt -s histreedit     # After a failed  history expansion (e.g.: !<too big number>), don't give me an empty prompt.
    shopt -s histverify     # After a history expansion, don't execute the resulting command immediately. Instead,  write the expanded command into the readline editing  buffer for further modification.

    # -----> Key binding
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

    # -----> Completion
    [[ -f /etc/bash_completion ]] && source /etc/bash_completion
fi

# ZSH
if [[ -n $ZSH_VERSION ]]; then
    # -----> Option
    # Changing Directories
    setopt AUTO_PUSHD               # Push the old directory onto the stack on cd.
    setopt CDABLE_VARS              # Change directory to a path stored in a variable.
    setopt PUSHD_IGNORE_DUPS        # Do not store duplicates in the stack.
    setopt PUSHD_MINUS              # Exchanges the meanings of ‘+’ and ‘-’ when used with a number to specify a directory in the stack.
    setopt PUSHD_SILENT             # Do not print the directory stack after pushd or popd.
    setopt PUSHD_TO_HOME            # Push to home directory when no argument is given.
    # Completion
    setopt ALWAYS_TO_END            # Move cursor to the end of a completed word.
    setopt COMPLETE_IN_WORD         # Complete from both ends of a word.
    setopt LIST_PACKED              # Try to make the completion list smaller (occupying less lines) by printing the matches in columns with different widths.
    setopt MENU_COMPLETE            # Autoselect the first completion entry.
    unsetopt LIST_BEEP              # Do not beep on an ambiguous completion.
    # Expansion and Globbing
    setopt BRACE_CCL                # Expand expressions in braces which would not otherwise undergo brace expansion to a lexically ordered list of all the characters.
    setopt EXTENDED_GLOB            # Treat the ‘#’, ‘~’ and ‘^’ characters as part of patterns for filename generation, etc.
    setopt MAGIC_EQUAL_SUBST        # Make zsh perform filename expansion on the command arguments of the form `var=val`.
    unsetopt CASE_GLOB              # Make globbing (filename generation) sensitive to case.
    # History
    setopt EXTENDED_HISTORY         # Write the history file in the ':start:elapsed;command' format.
    setopt HIST_EXPIRE_DUPS_FIRST   # Expire a duplicate event first when trimming history.
    setopt HIST_FIND_NO_DUPS        # Do not display a previously found event.
    setopt HIST_IGNORE_ALL_DUPS     # Delete an old recorded event if a new event is a duplicate.
    setopt HIST_IGNORE_DUPS         # Do not record an event that was just recorded again.
    setopt HIST_IGNORE_SPACE        # Do not record an event starting with a space.
    setopt HIST_REDUCE_BLANKS       # Remove superfluous blanks from each command line being added to the history list.
    setopt HIST_SAVE_NO_DUPS        # Do not write a duplicate event to the history file.
    setopt HIST_VERIFY              # Do not execute immediately upon history expansion.
    setopt INC_APPEND_HISTORY       # Write to the history file immediately, not when the shell exits.
    setopt SHARE_HISTORY            # Share history between all sessions.
    unsetopt HIST_BEEP              # Do not beep when accessing non-existent history.
    # Input/Output
    setopt INTERACTIVE_COMMENTS     # Enable comments in interactive shell.
    setopt PATH_DIRS                # Perform path search even on command names with slashes.
    setopt RC_QUOTES                # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'.
    setopt RM_STAR_SILENT           # Do not query the user before executing `rm *` or `rm path/*`.
    unsetopt CORRECT                # Do not try to correct the spelling of commands.
    unsetopt FLOW_CONTROL           # Disable start/stop characters in shell editor.
    # Job Control
    setopt AUTO_RESUME              # Attempt to resume existing job before creating a new process.
    setopt LONG_LIST_JOBS           # List jobs in the long format by default.
    unsetopt BG_NICE                # Don't run all background jobs at a lower priority.
    unsetopt CHECK_JOBS             # Don't report on jobs when shell exit.
    unsetopt HUP                    # Don't kill jobs on shell exit.
    # Prompting
    setopt PROMPT_SUBST             # If set, parameter expansion, command substitution and arithmetic expansion are performed in prompts.
    setopt TRANSIENT_RPROMPT        # Remove any right prompt from display when accepting a command line. This may be useful with terminals with other cut/paste methods.
    # Zle
    setopt COMBINING_CHARS          # Combine zero-length punctuation characters (accents) with the base character.
    unsetopt BEEP                   # Do not beep on error in line editor.

    # -----> Key binding
    bindkey -e                      # Use Emacs key bindings

    # create a zkbd compatible hash;
    # to add other keys to this hash, see: man 5 terminfo
    typeset -g -A key=(
        Home        ${terminfo[khome]}
        End         ${terminfo[kend]}
        Insert      ${terminfo[kich1]}
        Backspace   ${terminfo[kbs]}
        Delete      ${terminfo[kdch1]}
        Up          ${terminfo[kcuu1]}
        Down        ${terminfo[kcud1]}
        Left        ${terminfo[kcub1]}
        Right       ${terminfo[kcuf1]}
        PageUp      ${terminfo[kpp]}
        PageDown    ${terminfo[knp]}
        Shift-Tab   ${terminfo[kcbt]}
    )

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

    # Quote URLs automatically as you type
    autoload -Uz url-quote-magic
    zle -N self-insert url-quote-magic

    # -----> Completion
    # Load and initialize the zsh completion system.
    # If you use zinit, comment below to avoid compinit duplicate initialization.
    # autoload -Uz compinit
    # if [[ -f $_comp_path ]]; then
    #     compinit -C -d "$XDG_CACHE_HOME/zsh/zcompdump" # -C: skip function check
    # else
    #     compinit -i -d "$XDG_CACHE_HOME/zsh/zcompdump" # -i: skip security check
    # fi

    # use a cache in order to make completion for commands such as dpkg and apt usable.
    zstyle ':completion::complete:*' use-cache on
    zstyle ':completion::complete:*' cache-path $XDG_CACHE_HOME/zsh

    # case-insensitive (all), partial-word, and then substring completion.
    zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'

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
    zstyle ':completion:*' list-separator '  #'

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
        adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
        clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
        gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
        ldap lp mail mailman mailnull man messagebus  mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
        operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
        usbmux uucp vcsa wwwrun xfs '_*'
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

    # disable named-directories autocompletion
    zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

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

    # -----> Plugin
    # zinit
    typeset -A ZINIT=(
        HOME_DIR        $XDG_DATA_HOME/zsh/zinit
        ZCOMPDUMP_PATH  $XDG_CACHE_HOME/zsh/zcompdump
        COMPINIT_OPTS   -C
    )

    # zinit install
    [[ -d $ZINIT[HOME_DIR] ]] || command mkdir -p $ZINIT[HOME_DIR]
    if [[ ! -f $ZINIT[HOME_DIR]/bin/zinit.zsh ]]; then
        command git clone --depth=1 https://github.com/zdharma/zinit.git $ZINIT[HOME_DIR]/bin
    fi
    source $ZINIT[HOME_DIR]/bin/zinit.zsh

    # zinit compinit
    autoload -Uz _zinit
    (( ${+_comps} )) && _comps[zinit]=_zinit

    # zinit plugin
    zinit ice wait lucid atinit'zpcompinit; zpcdreplay' depth'1'
    zinit light zdharma/fast-syntax-highlighting

    zinit ice wait lucid atload'_zsh_autosuggest_start' depth'1'
    zinit light zsh-users/zsh-autosuggestions

    zinit ice wait lucid blockf depth'1'
    zinit light zsh-users/zsh-completions

    zinit ice lucid depth'1'
    zinit light zdharma/history-search-multi-word

    zinit ice lucid has'docker' as'completion'
    zinit snippet 'https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker'

    zinit ice lucid has'docker-compose' as'completion'
    zinit snippet 'https://github.com/docker/compose/blob/master/contrib/completion/zsh/_docker-compose'

    zinit ice has'kubectl' id-as'kubectl' as"null" wait silent nocompile \
        atclone'kubectl completion zsh >! _kubectl' \
        atpull'%atclone' src"_kubectl" run-atpull \
        atload'zicdreplay'
    zinit light zdharma/null

    # -----> Command-not-found
    [[ -f /etc/zsh_command_not_found ]] && source /etc/zsh_command_not_found
fi

# ============> Custom <============
# ls colors highlight
if [[ $OSTYPE == linux* ]]; then
    export LS_COLORS='bd=38;5;68:ca=38;5;17:cd=38;5;113;1:di=38;5;30:do=38;5;127:ex=38;5;208;1:pi=38;5;126:fi=0:ln=target:mh=38;5;222;1:no=0:or=48;5;196;38;5;232;1:ow=38;5;220;1:sg=48;5;3;38;5;0:su=38;5;220;1;3;100;1:so=38;5;197:st=38;5;86;48;5;234:tw=48;5;235;38;5;139;3'
else
    export LSCOLORS="Gxfxcxdxbxegedabagacad"
fi

# History
if [[ -n $BASH_VERSION ]]; then
    export HISTCONTROL=ignoreboth
    export HISTIGNORE='ls:ll:la:ls -a:ls -l:ls -al:ls -alh:pwd:clear:cd:cd ..:history'
    export HISTFILE=$HOME/.bash_history
fi
if [[ -n $ZSH_VERSION ]]; then
    export HISTORY_IGNORE='(ls|ll|la|ls -a|ls -l|ls -al|ls -alh|pwd|clear|cd|cd ..|history)'
    export HISTFILE=$HOME/.zsh_history
fi
export HISTSIZE=100000
export SAVEHIST=$HISTSIZE

# Editor
export EDITOR='vim'
export VISUAL='vim'

# Less
export PAGER='less -FRX'
export LESSCHARSET=utf-8
export LESSHISTFILE=-
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;32m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;44;33m'
export LESS_TERMCAP_se=$'\e[0m'

# Language
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# /usr/sbin, /usr/local/sbin, ~/.local/bin
[[ -d /usr/sbin ]]        && export PATH=/usr/sbin:$PATH
[[ -d /usr/local/sbin ]]  && export PATH=/usr/local/sbin:$PATH
[[ -d $HOME/.local/bin ]] && export PATH=$HOME/.local/bin:$PATH

# Homebrew
if [[ $OSTYPE == darwin* ]]; then
    export HOMEBREW_NO_ANALYTICS=1
    export HOMEBREW_NO_AUTO_UPDATE=1
fi

# Golang
case $OSTYPE in
     linux*) export \
        GOROOT=$XDG_DATA_HOME/go/go1.16.5 \
        GOBASEPATH=$HOME/projects/go;;
    darwin*) export \
        GOBASEPATH=$HOME/Projects/Go;;
esac
export GO111MODULE=on
# export GOPROXY=https://goproxy.cn,direct
export GOPATH=$GOBASEPATH
export GOENV=$XDG_CONFIG_HOME/go/env
export GOCACHE=$XDG_CACHE_HOME/go-build
export GOLANGCI_LINT_CACHE=$XDG_CACHE_HOME/golangci-lint
export PATH=$GOROOT/bin:$GOPATH/bin:$PATH

alias gohere='export GOPATH=`pwd`'
alias gobase='export GOPATH=$GOBASEPATH'

# Rust
if [[ $OSTYPE == darwin* ]]; then
    export RUST_TOOLCHAIN=stable-x86_64-apple-darwin
    export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup
fi
export RUSTUP_HOME=$XDG_DATA_HOME/rustup
export CARGO_HOME=$XDG_DATA_HOME/cargo
export PATH=$CARGO_HOME/bin:$PATH

# Python
export PYTHONSTARTUP=$XDG_CONFIG_HOME/python/startup.py
export IPYTHONDIR=$XDG_CONFIG_HOME/jupyter
export JUPYTER_CONFIG_DIR=$XDG_CONFIG_HOME/jupyter
export PYLINTHOME=$XDG_CACHE_HOME/pylint

# Ruby -> gems
export GEM_HOME=$XDG_DATA_HOME/gem
export GEM_SPEC_CACHE=$XDG_CACHE_HOME/gem

# Ruby -> bundler
export BUNDLE_USER_CONFIG=$XDG_CONFIG_HOME/bundle
export BUNDLE_USER_CACHE=$XDG_CACHE_HOME/bundle
export BUNDLE_USER_PLUGIN=$XDG_DATA_HOME/bundle

# Java
if [[ $OSTYPE == darwin* ]]; then
    export JAVA_HOME=$(/usr/libexec/java_home)
    export CLASSPATH=$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib/dt.jar
    export PATH=$JAVA_HOME/bin:$PATH
fi

# LLVM
if [[ -d /usr/local/opt/llvm/bin ]]; then
    export PATH=/usr/local/opt/llvm/bin:$PATH
fi

# Node && nvm
export NODE_REPL_HISTORY=-
export NVM_DIR=$XDG_DATA_HOME/nvm

if [[ -d $NVM_DIR ]]; then
    export NVM_NO_USE=false
    export NVM_LAZY_LOAD=true
    export NVM_LAZY_LOAD_EXTRA_COMMANDS=(vim nvim)

    _nvm_load() {
        if [[ $NVM_NO_USE == true ]]; then
            source $NVM_DIR/nvm.sh --no-use
        else
            source $NVM_DIR/nvm.sh
        fi
    }

    _nvm_global_binaries() {
        [[ -n $ZSH_VERSION ]] && unsetopt NOMATCH
        echo $NVM_DIR/v0*/bin/* $NVM_DIR/versions/*/*/bin/* |
            xargs -n 1 basename | sort | uniq | tr -d '*'
    }

    _nvm_lazy_load() {
        local global_binaries
        if [[ $NVM_NO_USE == true ]]; then
            global_binaries=()
        else
            global_binaries=($(_nvm_global_binaries))
        fi
        global_binaries+=(nvm)
        global_binaries+=($NVM_LAZY_LOAD_EXTRA_COMMANDS)

        local cmds
        cmds=()
        for bin in ${global_binaries[@]}; do
            [[ $(which $bin 2> /dev/null) = "$bin: aliased to "* ]] || cmds+=($bin)
        done

        for cmd in ${cmds[@]}; do
            eval "$cmd(){
                unset -f ${cmds[@]} > /dev/null 2>&1
                _nvm_load
                $cmd \"\$@\"
            }"
        done
    }

    if [[ $NVM_LAZY_LOAD == true ]]; then
        _nvm_lazy_load
    else
        _nvm_load
    fi
fi

install_nvm() {
    if [[ ! -f $NVM_DIR/nvm.sh ]]; then
        echo "$NVM_DIR/nvm.sh doesn't exists."
        echo "Downloading nvm.sh from github to $NVM_DIR/nvm.sh ..."
        echo `curl --connect-timeout 5 --compressed --create-dirs --progress-bar -fLo \
            $NVM_DIR/nvm.sh https://raw.githubusercontent.com/nvm-sh/nvm/master/nvm.sh`
    fi
    source $XDG_CONFIG_HOME/init.sh
}

# Docker
export DOCKER_CONFIG=$XDG_CONFIG_HOME/docker

# GnuPG
export GNUPGHOME=$XDG_DATA_HOME/gnupg
if [[ ! -d $GNUPGHOME ]] && command -v gpg > /dev/null; then
    command mkdir -m700 -p $GNUPGHOME
fi

# Common alias
case $OSTYPE in
     linux*|cygwin*|msys*) alias ls='ls --color -h';;
    darwin*|*bsd*|FreeBSD) alias ls='ls -Gh';;
esac
alias ll='ls -l'
alias la='ll -a'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ..='cd ..'
alias ...='cd ../..'

alias dud='du -d 1 -h'
alias duf='du -sh *'
alias job='jobs -l'

alias vi='vim -N -u NONE -i NONE'

# Proxy
proxy_addr="127.0.0.1:7890"
# proxy_addr="10.0.0.4:7890"
no_proxy_addr="localhost,127.0.0.0/8,*.local"

alias httpproxy="all_proxy=http://$proxy_addr no_proxy=$no_proxy_addr"
alias socks5proxy="all_proxy=socks5://$proxy_addr no_proxy=$no_proxy_addr"

fuckgfw() {
    echo "Proxy Address: $proxy_addr"
    export no_proxy=$no_proxy_addr
    export all_proxy=http://$proxy_addr
    echo "You are fucking the GFW!"
}

okgfw() {
    unset all_proxy ALL_PROXY
    echo "Remember fuck the GFW forever!"
}

# Typora
if [[ $OSTYPE == darwin* ]]; then
    alias typora='open -a typora'
    alias blog='open -a typora ~/Workspace/Github/blog'
    alias wiki='open -a typora ~/Workspace/Github/wiki'
fi

# Frequently
alias vimrc='vim ~/.vimrc'
alias workbench='tmux new -A -c ~/Workspace/Github -s Workbench'
alias cdr='cd $(git rev-parse --show-toplevel)'

# Tools
alias weather='_weather(){curl -H "Accept-Language: ${LANG%_*}" --compressed v2.wttr.in/${1-Beijing}};_weather'
alias cheat='_cheat(){curl cheat.sh/$1};_cheat'
alias dict='_dict(){curl dict://dict.org/d:$1:gcide};_dict'
alias ipinfo='curl wtfismyip.com/json'
alias randname='curl pseudorandom.name'
alias serve='python3 -m http.server 8000'
alias venv='python3 -m venv'
alias lstree="find . -print | sed -e 's;[^/]*/;|---;g;s;---|; |;g'"
alias certexp='_certexp(){openssl s_client -connect $1:443 -servername $1 2> /dev/null | openssl x509 -noout -dates};_certexp'

# Display shell startup time
timeshell() {
    local shell=${1-$SHELL}
    echo "Timing $shell:"
    for i in $(seq 1 5); do time $shell -i -c exit; done
}

# Display cmd statistics
cmdrank() {
    fc -l 1 \
        | awk '{ CMD[$2]++; count++; } END { for (a in CMD) print CMD[a] " " CMD[a]*100/count "% " a }' \
        | grep -v "./" | sort -nr | head -n20 | column -c3 -s " " -t | nl
}

# Display a random quote
quote() {
    Q=$(curl -s --connect-timeout 2 "http://www.quotationspage.com/random.php" | iconv -c -f ISO-8859-1 -t UTF-8 | grep -m 1 "dt ")

    TXT=$(echo "$Q" | sed -e 's/<\/dt>.*//g' -e 's/.*html//g' -e 's/^[^a-zA-Z]*//' -e 's/<\/a..*$//g')
    WHO=$(echo "$Q" | sed -e 's/.*\/quotes\///g' -e 's/<.*//g' -e 's/.*">//g')

    [[ -n $WHO && -n $TXT ]] && print -P "%F{3}${WHO}%f: \"%F{5}${TXT}%f\""
}

# Web search
websearch() {
    typeset -A urls
    local urls=(
        google          "https://www.google.com/search?q="
        bing            "https://www.bing.com/search?q="
        github          "https://github.com/search?q="
        baidu           "https://www.baidu.com/s?wd="
        goodreads       "https://www.goodreads.com/search?q="
        stackoverflow   "https://stackoverflow.com/search?q="
        wolframalpha    "https://www.wolframalpha.com/input/?i="
        archive         "https://web.archive.org/web/*/"
        scholar         "https://scholar.google.com/scholar?q="
        doubanbook      "https://search.douban.com/book/subject_search?search_text="
    )

    if [[ -z $urls[$1] ]]; then
        echo "Search engine '$1' not supported."
        return 1
    fi

    if [[ $# -gt 1 ]]; then
        local escape_str=`echo -n "${@:2}" | sed 's/ /+/g' | xxd -ps | tr -d '\n' | sed -r 's/(..)/%\1/g'`
        local url="${urls[$1]}${escape_str}"

        case $OSTYPE in
             linux*) xdg-open $url;;
            darwin*) open $url;;
        esac
    fi
}

if [[ $OSTYPE == linux* || $OSTYPE == darwin* ]]; then
    alias bing='websearch bing'
    alias google='websearch google'
    alias github='websearch github'
    alias baidu='websearch baidu'
    alias goodreads='websearch goodreads'
    alias sof='websearch stackoverflow'
    alias wolframalpha='websearch wolframalpha'
    alias archive='websearch archive'
    alias scholar='websearch scholar'
    alias doubanbook='websearch doubanbook'
fi

# ============> Finally <============
# Remove duplicate path
if [[ -n $PATH ]]; then
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
fi
export PATH
