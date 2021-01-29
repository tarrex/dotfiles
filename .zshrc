# .zshrc

# -----> performance
# zmodload zsh/datetime
# setopt PROMPT_SUBST
# PS4='+$EPOCHREALTIME %N:%i> '
#
# logfile=$(mktemp zsh_profile)
# echo "Logging to $logfile"
# exec 3>&2 2>$logfile
#
# setopt XTRACE

# User configuration
[[ -f $HOME/.config/init.sh ]] && source $HOME/.config/init.sh

# -----> performance
# unsetopt XTRACE
# exec 2>&3 3>&-
