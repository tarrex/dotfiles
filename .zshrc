# .zshrc

# -----> performance
# zmodload zsh/datetime
# setopt PROMPT_SUBST
# PS4='+$EPOCHREALTIME %N:%i> '
#
# logfile=$(mktemp zsh_profile.7Pw1Ny0G)
# echo "Logging to $logfile"
# exec 3>&2 2>$logfile
#
# setopt XTRACE

# User configuration
if [ -f "$HOME/.config/init.sh" ]; then
    . $HOME/.config/init.sh
fi

# -----> performance
# unsetopt XTRACE
# exec 2>&3 3>&-
