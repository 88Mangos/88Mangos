# zmodload zsh/zprof

fpath=(~/.zsh $fpath)
# --------------------------------------------------------------------------- #
# HISTORY & OPTIONS
# --------------------------------------------------------------------------- #
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY # adds timestamps to history entries
setopt autocd # change dirs w/out typing cd
set -o vi # Vim mode for editing commands

# --------------------------------------------------------------------------- #
# COMPLETIONS (Optimized to run check only once per day)
# --------------------------------------------------------------------------- #
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit -d ~/.zsh/cache/zcompdump
else
  compinit -C
fi

# --------------------------------------------------------------------------- #
# TOOL & ENV
# --------------------------------------------------------------------------- #
source <(fzf --zsh) # fzf setup
. "$HOME/.local/bin/env" # uv, LMStudio CLI setup
eval "$(fnm env --use-on-cd)" # npm, but in Rust

# Legacy Conda support for old environments I probably won't use anymore
alias sysconda='export PATH="/opt/anaconda3/bin:$PATH" && echo "Conda loaded."'

# --------------------------------------------------------------------------- #
# ALIASES & PROMPT
# --------------------------------------------------------------------------- #
alias ls='ls -G' # add colors to ls
alias smlnj='rlwrap sml'
alias awslocal='aws --endpoint-url=http://localhost:4566' # LocalStack

alias homework="tmux new-session -A -s homework\; split-window -h"

# PATH: SML/NJ, Postgres, Julia, LMStudio CLI (lms)
export PATH=/usr/local/smlnj/bin:/Library/PostgreSQL/16/bin:/Users/tyleryang/.juliaup/bin:/Users/tyleryang/.lmstudio/bin:$PATH

PROMPT='%F{green}%n:%F{blue}%~%f$ ' # username:~$

# --------------------------------------------------------------------------- #
# PLUGINS (Load last to prevent lag)
# --------------------------------------------------------------------------- #
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zprof
