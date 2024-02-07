#!/bin/zsh
#
# .zshrc - Zsh file loaded on interactive shell sessions.
#

# Extras
export NDOTDIR=${HOME}/.config/nvim
export NSWAPDIR=${HOME}/.local/state/nvim/swap/

# Zsh options.
setopt extended_glob appendhistory EXTENDED_HISTORY HIST_FIND_NO_DUPS HIST_IGNORE_ALL_DUPS promptsubst
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$HOME/.histfile
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char
bindkey '^[[A' history-substring-search-up
bindkey '^[OA' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[OB' history-substring-search-down
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
autoload -U colors && colors

# Autoload functions you might want to use with antidote.
ZFUNCDIR=${ZFUNCDIR:-$ZDOTDIR/functions}
fpath=($ZFUNCDIR $fpath)
autoload -Uz $fpath[1]/*(.:t)

# Source zstyles you might use with antidote.
[[ -e ${ZDOTDIR:-~}/.zstyles ]] && source ${ZDOTDIR:-~}/.zstyles

# Clone antidote if necessary.
[[ -d ${ZDOTDIR:-~}/.antidote ]] ||
  git clone https://github.com/mattmc3/antidote ${ZDOTDIR:-~}/.antidote

# Create an amazing Zsh config using antidote plugins.
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load

if grep -qi 'Arch' /etc/os-release; then
    if command -v archey &> /dev/null; then
        archey
    fi
elif grep -qiE 'debian|ubuntu' /etc/os-release; then
    if command -v neofetch &> /dev/null; then
        neofetch
    fi
    if grep -qi 'microsoft' /proc/version; then
	browser_path="$ZDOTDIR/open-browser.sh"
        export BROWSER="$browser_path"
    fi
fi

if [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh
fi

