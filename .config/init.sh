# Tarrex's bash/zsh initialization file.

# ============> Prepare <============
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Disable software flow control Ctrl+S (freeze) and Ctrl+Q (restore) in terminal
[[ -t 0 ]] && command stty -ixon 2>/dev/null

# XDG base directories specification
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}

# Explicit command paths are prepended so configured tools take precedence.
[[ -d /usr/sbin ]]        && PATH=/usr/sbin:$PATH
[[ -d /usr/local/sbin ]]  && PATH=/usr/local/sbin:$PATH
[[ -d $HOME/.local/bin ]] && PATH=$HOME/.local/bin:$PATH

# Feature switches; leave a value empty to disable the corresponding feature.
_ENABLE_Z=true
_ENABLE_GIT_PROMPT=true
_ENABLE_ZINIT=true
_ENABLE_FZF=true

# Homebrew must be initialized before dependency detection and compinit.
if [[ $OSTYPE == darwin* && -x /opt/homebrew/bin/brew ]]; then
    export HOMEBREW_NO_ANALYTICS=1
    eval "$(/opt/homebrew/bin/brew shellenv zsh)"
fi

# ============> Environment <============
# Configure every command path before dependency detection and completion.

# Local applications
[[ -d $HOME/.local/nvim/bin ]] && PATH=$HOME/.local/nvim/bin:$PATH

# Preferred applications
export PAGER=less
if command -v nvim >/dev/null 2>&1; then
    EDITOR=nvim
elif command -v vim >/dev/null 2>&1; then
    EDITOR=vim
else
    EDITOR=vi
fi
export EDITOR
export VISUAL=$EDITOR
[[ $OSTYPE == darwin* ]] && export BROWSER=open

# Timezone
export TZ=Asia/Shanghai

# less
export LESS='-g -i -M -R -S -w -z-4'
export LESSHISTFILE=-

# ls colors
export LS_COLORS='bd=38;5;68:ca=38;5;17:cd=38;5;113;1:di=38;5;30:do=38;5;127:ex=38;5;208;1:pi=38;5;126:fi=0:ln=target:mh=38;5;222;1:no=0:or=48;5;196;38;5;232;1:ow=38;5;220;1:sg=48;5;3;38;5;0:su=38;5;220;1;3;100;1:so=38;5;197:st=38;5;86;48;5;234:tw=48;5;235;38;5;139;3'
[[ $OSTYPE == darwin* || $OSTYPE == *bsd* ]] && export LSCOLORS='Gxfxcxdxbxegedabagacad'

# Go
export GOPATH=$HOME/Workspace/GoProjects
export GOCACHE=$XDG_CACHE_HOME/go-build     # go clean -cache
export GOLANGCI_LINT_CACHE=$XDG_CACHE_HOME/golangci-lint
export GOPROXY=https://goproxy.cn,direct
[[ -d /usr/local/go/bin ]] && PATH=/usr/local/go/bin:$PATH
PATH=$GOPATH/bin:$PATH

# Rust
export RUSTUP_HOME=$XDG_DATA_HOME/rustup
export CARGO_HOME=$XDG_DATA_HOME/cargo
PATH=$CARGO_HOME/bin:$PATH

# Python
if [[ -r $XDG_CONFIG_HOME/python/startup.py ]]; then
    export PYTHONSTARTUP=$XDG_CONFIG_HOME/python/startup.py
else
    unset PYTHONSTARTUP
fi
# Prevent Python from modifying the prompt during environment activation.
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Node; an empty value disables persistent REPL history.
export NODE_REPL_HISTORY=
if [[ -d $HOME/.local/node/bin ]]; then
    PATH=$HOME/.local/node/bin:$PATH
elif [[ -d /usr/local/node/bin ]]; then
    PATH=/usr/local/node/bin:$PATH
fi

# OrbStack
[[ -d $HOME/.orbstack/bin ]] && PATH=$HOME/.orbstack/bin:$PATH

# Keep the first occurrence of each command path. This also makes repeated
# sourcing idempotent before any dependency checks are performed.
_deduplicate_path() {
    [[ -z $PATH ]] && return 0
    local old_PATH=$PATH: x
    PATH=
    while [[ -n $old_PATH ]]; do
        x=${old_PATH%%:*}
        case $PATH: in
            *:"$x":*) ;;
            *) PATH=$PATH:$x ;;
        esac
        old_PATH=${old_PATH#*:}
    done
    PATH=${PATH#:}
}
_deduplicate_path
export PATH

# ============> Dependencies <============
# Available dependencies
_check_dependencies() {
    unset _INSTALLED_GIT _INSTALLED_TMUX _INSTALLED_FZF

    command -v git  >/dev/null 2>&1 && _INSTALLED_GIT=true
    command -v tmux >/dev/null 2>&1 && _INSTALLED_TMUX=true
    command -v fzf  >/dev/null 2>&1 && _INSTALLED_FZF=true
}
_check_dependencies

# ============> Core helpers <============
# Download to a temporary path and replace the destination only on success.
_downloader() {
    local url=$1 dest=$2 tmp=$2.tmp.$$

    command mkdir -p -- "${dest%/*}" || return
    printf 'Downloading %s...\n' "${dest##*/}"

    if command -v curl >/dev/null 2>&1; then
        command curl -fsSL --connect-timeout 5 --max-time 30 -o "$tmp" "$url"
    elif command -v wget >/dev/null 2>&1; then
        command wget -nv -T 30 -t 1 -O "$tmp" "$url"
    else
        printf 'curl or wget is required\n' >&2 && return 1
    fi && command mv -f -- "$tmp" "$dest" && return

    command rm -f -- "$tmp"
    return 1
}

# ============> Shell <============
# bash config
if [[ -n $BASH_VERSION ]]; then
    # use `shopt`` to check current options
    # use `shopt -p` to check the special option
    shopt -s checkjobs
    shopt -s histappend
    shopt -s histverify
    shopt -s no_empty_cmd_completion

    # History
    HISTSIZE=100000
    HISTFILESIZE=100000
    HISTCONTROL=ignoreboth

    # Load system-wide programmable completion when available.
    [[ ! ${BASH_COMPLETION_VERSINFO:-} &&
        -r /usr/share/bash-completion/bash_completion ]] &&
        source /usr/share/bash-completion/bash_completion
fi

# zsh config
if [[ -n $ZSH_VERSION ]]; then
    # Completion
    setopt COMPLETE_IN_WORD
    # History
    setopt EXTENDED_HISTORY
    setopt HIST_FIND_NO_DUPS
    setopt HIST_IGNORE_DUPS
    setopt HIST_IGNORE_SPACE
    setopt HIST_REDUCE_BLANKS
    setopt HIST_SAVE_NO_DUPS
    setopt HIST_EXPIRE_DUPS_FIRST
    setopt HIST_VERIFY
    setopt SHARE_HISTORY
    setopt HIST_FCNTL_LOCK
    HISTSIZE=120000
    SAVEHIST=100000
    HISTFILE=$HOME/.zsh_history
    # Input/Output
    setopt INTERACTIVE_COMMENTS

    # -----> ZLE
    # Compared with the default, /, ., -, < and > are word boundaries.
    WORDCHARS='*?_[]~=&;!#$%^(){}'

    # Use a deterministic Emacs-style keymap.
    bindkey -e

    # Search history using the command line prefix before the cursor.
    autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
    zle -N up-line-or-beginning-search
    zle -N down-line-or-beginning-search
    bindkey '\e[A' up-line-or-beginning-search
    bindkey '\eOA' up-line-or-beginning-search
    bindkey '\e[B' down-line-or-beginning-search
    bindkey '\eOB' down-line-or-beginning-search

    # Edit the current command line in $VISUAL or $EDITOR.
    autoload -Uz edit-command-line
    zle -N edit-command-line
    bindkey '\C-x\C-e' edit-command-line

    # Quote pasted URLs
    autoload -Uz bracketed-paste-url-magic
    zle -N bracketed-paste bracketed-paste-url-magic
fi

# ============> Integrations <============
# z.sh directory tracking
_load_z() {
    local script=$XDG_DATA_HOME/z/z.sh
    local url=https://raw.githubusercontent.com/rupa/z/master/z.sh

    _Z_DATA=$XDG_DATA_HOME/z/zdata
    [[ -f $script ]] || _downloader "$url" "$script" || return
    source "$script"
}
[[ -n $_ENABLE_Z ]] && _load_z

# fzf shell integration and interactive helpers
if [[ -n $_ENABLE_FZF && -n $_INSTALLED_FZF ]]; then
    # Assign instead of appending so re-sourcing init.sh stays idempotent.
    export FZF_DEFAULT_OPTS='--height=40% --layout=reverse
    --color=light
    --color=fg:-1,bg:-1,hl:#ffaf5f,fg+:-1,bg+:-1,hl+:#ffaf5f
    --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7
    --color=marker:#ff87d7,spinner:#ff87d7,header:#af87ff'

    # Official shell integration: key bindings and fuzzy completion.
    export FZF_COMPLETION_TRIGGER='~~'
    if [[ -n $ZSH_VERSION ]]; then
        # Ctrl-R is provided by history-search-multi-word.
        FZF_CTRL_R_COMMAND= source <(fzf --zsh)
    else
        eval "$(fzf --bash)"
    fi

    if [[ -n $_INSTALLED_TMUX ]]; then
        # Create, attach to, or switch to a tmux session.
        tm() {
            local session

            if [[ -n $1 ]]; then
                session=$1
            else
                session=$(tmux list-sessions -F '#S' 2>/dev/null |
                    fzf --bind='enter:accept-or-print-query') || return
                [[ -n $session ]] || return
            fi

            if [[ -n $TMUX ]]; then
                tmux switch-client -t "$session" 2>/dev/null ||
                    { tmux new-session -d -s "$session" &&
                      tmux switch-client -t "$session"; }
            else
                tmux new-session -A -s "$session"
            fi
        }

        # Switch panes in the current tmux session.
        tp() {
            [[ -n $TMUX ]] || {
                printf 'tp: not inside tmux\n' >&2
                return 1
            }

            local pane
            pane=$(
                tmux list-panes -s \
                    -F $'#{pane_id}\t#I:#P - #{pane_current_path} #{pane_current_command}' |
                    fzf --delimiter=$'\t' --with-nth=2.. --accept-nth=1
            ) || return

            tmux select-window -t "$pane" \; select-pane -t "$pane"
        }
    fi

    if [[ -n $_INSTALLED_GIT ]]; then
        # Browse changed files with a live diff preview.
        gdiff() {
            local args

            git rev-parse --is-inside-work-tree >/dev/null 2>&1 || {
                printf 'gdiff: not a Git repository\n' >&2
                return 1
            }

            args=$(git rev-parse --sq-quote "$@") || return
            git diff --name-only -z "$@" |
                fzf --read0 --multi \
                    --preview "git diff --color=always$args -- {}"
        }

        # Select and display a commit.
        gcommit() {
            local commit

            git rev-parse --is-inside-work-tree >/dev/null 2>&1 || {
                printf 'gcommit: not a Git repository\n' >&2
                return 1
            }

            commit=$(
                git log --color=always \
                    --format='%C(auto)%h %s %C(black)%C(bold)%cr%Creset%x09%H' |
                    fzf --ansi --no-sort \
                        --delimiter=$'\t' \
                        --with-nth=1 \
                        --accept-nth=2 \
                        --preview='git show --color=always {2}' \
                        --preview-window=right:60%
            ) || return

            git show "$commit"
        }
    fi

    if command -v gh >/dev/null 2>&1; then
        _gh_select() {
            gh "$1" list --json number,title \
                --jq '.[] | "\(.number)\t\(.title)"' |
                fzf --delimiter=$'\t' --accept-nth=1 \
                    --preview "$2" --preview-window=right:60%
        }

        ghpr() {
            local pr
            pr=$(_gh_select pr \
                'GH_FORCE_TTY=$FZF_PREVIEW_COLUMNS gh pr view {1}') ||
                return
            gh pr checkout "$pr"
        }

        ghdiff() {
            local pr
            pr=$(_gh_select pr \
                'GH_FORCE_TTY=$FZF_PREVIEW_COLUMNS gh pr diff --color=always {1}') ||
                return
            gh pr diff "$pr"
        }

        ghissue() {
            local issue
            issue=$(_gh_select issue \
                'GH_FORCE_TTY=$FZF_PREVIEW_COLUMNS gh issue view {1}') ||
                return
            gh issue view "$issue"
        }
    fi
fi

# ============> Commands <============
# Listing and file operations
case $OSTYPE in
    linux*)  alias ls='ls --color=auto -h';;
    darwin*) alias ls='ls -Gh';;
esac

if command -v eza >/dev/null 2>&1; then
    alias ll='eza -lF --icons --time-style=long-iso'
    alias la='eza -alF --icons --time-style=long-iso'
    alias lt='eza -T -L 2 --icons=auto'
else
    alias ll='ls -l'
    alias la='ll -a'
fi

alias grep='grep --color=auto'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias mkdir='mkdir -v'
alias ln='ln -v'

alias dud='du -d 1 -h'
alias duf='du -sh ./*'

alias venv='python3 -m venv'
alias serve='python3 -m http.server --bind 127.0.0.1'
alias randname='curl -fsSL https://pseudorandom.name'
alias ipinfo='curl -fsSL https://wtfismyip.com/yaml'

# Random values
alias randurl='python3 -c "import secrets; print(secrets.token_urlsafe(32))"'
alias randhex='openssl rand -hex 32'
alias randb64='openssl rand -base64 32'
alias uuid4='python3 -c "import uuid; print(uuid.uuid4())"'

# Timestamps
alias epoch='date +%s'
alias utcnow='date -u +%Y-%m-%dT%H:%M:%SZ'

# Listening TCP ports
command -v lsof >/dev/null 2>&1 && alias ports='lsof -nP -iTCP -sTCP:LISTEN'

command -v kitten >/dev/null 2>&1 && alias kssh='kitten ssh'

# Proxy
_proxy=127.0.0.1:7890
_noproxy=localhost,127.0.0.1,::1,.local

alias hproxy="env http_proxy=http://${_proxy} https_proxy=http://${_proxy} all_proxy=http://${_proxy} no_proxy=${_noproxy}"
alias sproxy="env http_proxy=socks5h://${_proxy} https_proxy=socks5h://${_proxy} all_proxy=socks5h://${_proxy} no_proxy=${_noproxy}"

gfw() {
    if [[ $http_proxy ]]; then
        unset http_proxy https_proxy all_proxy no_proxy
        printf 'Proxy disabled.\n'
        return
    fi
    local proxy=http://$_proxy
    export http_proxy="$proxy" https_proxy="$proxy" all_proxy="$proxy"
    export no_proxy="$_noproxy"
    printf 'Proxy enabled: %s\n' "$proxy"
}

pstatus() {
    local ip
    ip=$(command curl -fsSL --max-time 5 https://wtfismyip.com/text 2>/dev/null) || ip=Unavailable
    printf '%s\n' '-------- Proxy Status --------'
    printf '%12s %s\n' \
        'HTTP Proxy:'  "${http_proxy:-Not set}" \
        'HTTPS Proxy:' "${https_proxy:-Not set}" \
        'All Proxy:'   "${all_proxy:-Not set}" \
        'No Proxy:'    "${no_proxy:-Not set}" \
        'External IP:' "$ip"
    printf '%s\n' '------------------------------'
}

# shell startup time
timeshell() {
    local shell=${1:-$SHELL} i
    printf 'Timing %s:\n' "$shell"
    for ((i = 0; i < 5; i++)); do
        time "$shell" -i -c exit
    done
}

mkcd() { command mkdir -p -- "$1" && builtin cd -- "$1"; }
certexp() { command openssl s_client -connect "$1:443" -servername "$1" </dev/null 2>/dev/null | command openssl x509 -noout -dates; }
weather() { command curl -fsSL --compressed "https://v2.wttr.in/${1:-Beijing}"; }
cheat() { command curl -fsSL "https://cheat.sh/$1"; }
dict() { command curl -fsS "dict://dict.org/d:$1:${2:-gcide}"; }

# Extract one archive without deleting the source file.
extract() {
    (( $# == 1 )) || {
        printf 'usage: extract ARCHIVE\n' >&2
        return 64
    }

    local archive=$1 lower

    [[ -f $archive ]] || {
        printf 'extract: file not found: %s\n' "$archive" >&2
        return 1
    }

    # Prevent a leading "-" from being interpreted as an option.
    case $archive in
        -*) archive=./$archive ;;
    esac

    # Match extensions case-insensitively in both Bash and Zsh.
    lower=$(printf '%s' "$archive" | LC_ALL=C tr '[:upper:]' '[:lower:]')

    case $lower in
        (*.tar.bz2|*.tbz2) command tar --bzip2 -xf "$archive" ;;
        (*.tar.gz|*.tgz)   command tar --gzip -xf "$archive" ;;
        (*.tar.xz|*.txz)   command tar --xz -xf "$archive" ;;
        (*.tar.zst|*.tzst) command tar --zstd -xf "$archive" ;;
        (*.tar)            command tar -xf "$archive" ;;
        (*.zip)            command unzip "$archive" ;;
        (*.7z)             command 7z x "$archive" ;;
        (*.rar)            command unrar x "$archive" ;;
        (*.gz)             command gzip -dk "$archive" ;;
        (*.bz2)            command bzip2 -dk "$archive" ;;
        (*.xz)             command xz -dk "$archive" ;;
        (*.zst)            command zstd -dk "$archive" ;;
        (*) printf 'extract: unsupported archive: %s\n' "$archive" >&2; return 2 ;;
    esac
}

# ============> Prompt <============
# Load the Git-supplied prompt helper before assembling the prompt.
_load_git_prompt() {
    local script
    local url=https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh

    # Homebrew; CommandLineTools; Debian/Ubuntu; RHEL/Fedora; Arch Linux; Self download
    for script in \
        /opt/homebrew/etc/bash_completion.d/git-prompt.sh \
        /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh \
        /usr/lib/git-core/git-sh-prompt \
        /usr/share/git-core/contrib/completion/git-prompt.sh \
        /usr/share/git/completion/git-prompt.sh \
        "$XDG_DATA_HOME/git/git-prompt.sh"; do
        [[ -f $script ]] && break
    done

    [[ -f $script ]] || _downloader "$url" "$script" || return
    source "$script"
}
[[ -n $_INSTALLED_GIT && -n $_ENABLE_GIT_PROMPT ]] && _load_git_prompt

# Collapse parent directories while keeping the current directory intact.
_collapsed_pwd() {
    local pwd=${1:-$PWD} part result=

    # Display paths under HOME with the conventional ~ prefix.
    case $pwd in
        "$HOME")   pwd='~' ;;
        "$HOME"/*) pwd="~${pwd#"$HOME"}" ;;
    esac

    while [[ $pwd == */* ]]; do
        part=${pwd%%/*}
        pwd=${pwd#*/}

        # Keep two characters for hidden and other special directories.
        case $part in
            [._-]*) part=${part:0:2} ;;
            *)      part=${part:0:1} ;;
        esac
        result+=$part/
    done

    result+=$pwd

    # Prevent path names from being interpreted as Zsh prompt escapes.
    [[ -n $ZSH_VERSION ]] && result=${result//\%/%%}

    printf '%s\n' "$result"
}

# Prompt palette
_PROMPT_PALETTE=gruvbox
declare -A _colors

case $_PROMPT_PALETTE in
    native)    _colors=([success]=2   [error]=1   [user]=5   [root]=9   [dir]=6   [branch]=3   [prompt]=2   [venv]=4) ;;
    solarized) _colors=([success]=64  [error]=160 [user]=61  [root]=166 [dir]=33  [branch]=136 [prompt]=37  [venv]=244) ;;
    gruvbox)   _colors=([success]=142 [error]=167 [user]=175 [root]=208 [dir]=109 [branch]=214 [prompt]=108 [venv]=245) ;;
    nord)      _colors=([success]=144 [error]=131 [user]=139 [root]=173 [dir]=67  [branch]=186 [prompt]=110 [venv]=109) ;;
    *)         _colors=([success]=39  [error]=160 [user]=140 [root]=202 [dir]=51  [branch]=166 [prompt]=47  [venv]=152) ;;  # classic
esac

# Capture the previous command status before rendering the prompt.
_prompt_status() {
    LAST_EXIT_CODE=$?
    case $LAST_EXIT_CODE in
        0) _status_color=${_colors[success]} ;;
        *) _status_color=${_colors[error]} ;;
    esac
}

# Git branch
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=
GIT_PS1_DESCRIBE_STYLE=contains
GIT_PS1_SHOWUPSTREAM=auto
_gitbranch() {
    [[ -n $_INSTALLED_GIT && -n $_ENABLE_GIT_PROMPT ]] && __git_ps1 ' [%s]'
}

# Build the Bash or Zsh prompt after all shared integrations are configured.
_prompt_setting() {
    local prompt_end=❯ user=${_colors[user]}
    local venv='${VIRTUAL_ENV:+(${VIRTUAL_ENV##*/}) }'

    (( UID == 0 )) && user=${_colors[root]}
    _status_color=${_colors[success]}

    if [[ -n $BASH_VERSION ]]; then
        local status_color='\[\e[1;38;5;${_status_color}m\]'
        local user_color="\[\e[1;38;5;${user}m\]"
        local dir_color="\[\e[1;38;5;${_colors[dir]}m\]"
        local branch_color="\[\e[38;5;${_colors[branch]}m\]"
        local prompt_color="\[\e[1;38;5;${_colors[prompt]}m\]"
        local venv_color="\[\e[1;38;5;${_colors[venv]}m\]"
        local reset_color='\[\e[0m\]'

        # Preserve existing Bash prompt hooks.
        [[ ${PROMPT_COMMAND[*]-} == *'_prompt_status'* ]] ||
            PROMPT_COMMAND=(_prompt_status "${PROMPT_COMMAND[@]}")

        PS1="${status_color}λ ${reset_color}"
        PS1+="${venv_color}${venv}${reset_color}"
        PS1+="${user_color}\u@\h${reset_color}: "
        PS1+="${dir_color}\$(_collapsed_pwd)${reset_color}"
        PS1+="${branch_color}\$(_gitbranch)${reset_color}"
        PS1+=$'\n'
        PS1+="${prompt_color}${prompt_end}${reset_color} "
    elif [[ -n $ZSH_VERSION ]]; then
        local status_color='%F{${_status_color}}'
        local user_color="%F{${user}}"
        local dir_color="%F{${_colors[dir]}}"
        local branch_color="%F{${_colors[branch]}}"
        local prompt_color="%F{${_colors[prompt]}}"
        local venv_color="%F{${_colors[venv]}}"
        local reset_color=%f

        # Dynamic prompt content requires PROMPT_SUBST.
        setopt PROMPT_SUBST
        autoload -Uz add-zsh-hook
        add-zsh-hook precmd _prompt_status

        PROMPT="${status_color}%Bλ %b${reset_color}"
        PROMPT+="${venv_color}${venv}${reset_color}"
        PROMPT+="${user_color}%B%n@%m%b${reset_color}: "
        PROMPT+="${dir_color}%B\$(_collapsed_pwd)%b${reset_color}"
        PROMPT+="${branch_color}\$(_gitbranch)${reset_color}"
        PROMPT+=$'\n'
        PROMPT+="${prompt_color}%B${prompt_end}%b${reset_color} "
    fi
}
_prompt_setting

# ============> Zsh Completion and Plugins <============
# Completion and ZLE plugins are registered last, after command paths,
# integrations, aliases, widgets, and the prompt have all been configured.
if [[ -n $ZSH_VERSION ]]; then
    _zcompdump=$XDG_CACHE_HOME/zsh/zcompdump
    command mkdir -p "$XDG_CACHE_HOME/zsh"

    # Completion display
    # An empty value enables Zsh's default completion colors.
    zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
    zstyle ':completion:*:default' list-prompt '%S%M matches%s'
    zstyle ':completion:*:default' menu select
    zstyle ':completion:*' group-name ''
    zstyle ':completion:*' verbose yes
    zstyle ':completion:*' list-separator '  #'
    zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
    zstyle ':completion:*:messages' format '%F{magenta}-- %d --%f'
    zstyle ':completion:*:warnings' format '%F{red}-- no matches found --%f'
    zstyle ':completion:*:options' auto-description '%d'

    # Try exact, case-insensitive, then partial-word matching. Each entry causes
    # another completion attempt, so keep the list short.
    zstyle ':completion:*' matcher-list \
        '' \
        'm:{a-zA-Z}={A-Za-z}' \
        'm:{a-zA-Z}={A-Za-z} r:|[._-]=* r:|=*'

    # Completion cache
    zstyle ':completion:*' use-cache yes
    zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"

    # Hide internal functions unless they are the only available matches.
    zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
    zstyle ':completion:*' single-ignored show

    # Array subscripts
    zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

    # Directories
    zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
    zstyle ':completion:*:-tilde-:*' group-order named-directories path-directories users expand
    zstyle ':completion:*' squeeze-slashes true
    zstyle ':completion:*' special-dirs ..

    # History-word completion
    zstyle ':completion:*:history-words' stop yes
    zstyle ':completion:*:history-words' remove-all-dups yes
    zstyle ':completion:*:history-words' list false
    zstyle ':completion:*:history-words' menu yes

    # Don't offer arguments already present on the command line.
    zstyle ':completion:*:*:(rm|kill|diff):*:*' ignore-line other

    # Processes
    # -U works with the ps implementations used by macOS and Linux.
    zstyle ':completion:*:*:*:*:processes' command 'ps -U $USER -o pid,user,command'
    zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
    zstyle ':completion:*:*:kill:*' force-list always
    zstyle ':completion:*:*:kill:*' insert-ids single

    # Manual pages
    zstyle ':completion:*:manuals' separate-sections true
    zstyle ':completion:*:manuals.(^1*)' insert-sections true

    # Zinit bootstrap
    _zinit_loaded=

    if [[ -n $_ENABLE_ZINIT ]]; then
        typeset -A ZINIT=(
            HOME_DIR       "$XDG_DATA_HOME/zinit"
            BIN_DIR        "$XDG_DATA_HOME/zinit/bin"
            ZCOMPDUMP_PATH "$_zcompdump"
            COMPINIT_OPTS  -C
        )

        # Git is required for installation, but not for loading an existing
        # Zinit installation.
        if [[ ! -r $ZINIT[BIN_DIR]/zinit.zsh && -n $_INSTALLED_GIT ]]; then
            command mkdir -p "$ZINIT[HOME_DIR]"
            command git clone --depth 1 \
                https://github.com/zdharma-continuum/zinit.git \
                "$ZINIT[BIN_DIR]"
        fi

        if [[ -r $ZINIT[BIN_DIR]/zinit.zsh ]] &&
            source "$ZINIT[BIN_DIR]/zinit.zsh"; then
            _zinit_loaded=true
        fi
    fi

    if [[ -n $_zinit_loaded ]]; then
        # Command-generated completions must be registered before
        # zsh-completions triggers compinit.
        zinit ice wait lucid nocompile run-atpull \
            has'docker' as'completion' id-as'docker-completion' \
            atclone'docker completion zsh > _docker' atpull'%atclone'
        zinit light zdharma-continuum/null

        zinit ice wait lucid nocompile run-atpull \
            has'kubectl' as'completion' id-as'kubectl-completion' \
            atclone'kubectl completion zsh > _kubectl' atpull'%atclone'
        zinit light zdharma-continuum/null

        zinit ice wait lucid nocompile run-atpull \
            has'helm' as'completion' id-as'helm-completion' \
            atclone'helm completion zsh > _helm' atpull'%atclone'
        zinit light zdharma-continuum/null

        # Last completion provider: initialize Zsh completion once everything above has been registered.
        zinit ice wait lucid blockf atload'zicompinit; zicdreplay' depth'1' id-as'zsh-completions'
        zinit light zsh-users/zsh-completions

        # ZLE plugins
        zinit ice wait lucid depth'1' id-as'history-search-multi-word'
        zinit light zdharma-continuum/history-search-multi-word

        zinit ice wait lucid atload'_zsh_autosuggest_start' depth'1' id-as'zsh-autosuggestions'
        zinit light zsh-users/zsh-autosuggestions

        # Required by this plugin's own installation documentation: load after
        # other plugins that create or wrap ZLE widgets.
        zinit ice wait lucid depth'1' id-as'zsh-syntax-highlighting'
        zinit light zsh-users/zsh-syntax-highlighting
    else
        # Zinit was disabled, unavailable, or failed to load. Let compinit
        # manage its own dump and perform the normal security check.
        autoload -Uz compinit
        compinit -d "$_zcompdump"
    fi
    unset _zcompdump _zinit_loaded
fi
