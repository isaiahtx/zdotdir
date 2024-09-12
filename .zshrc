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


if [[ -f /etc/os-release ]] && grep -qi 'Arch' /etc/os-release; then
    export PATH="${PATH}:/home/isaia/.local/share/gem/ruby/3.0.0/bin"
    if grep -qi 'microsoft' /proc/version; then
        # For some reason Wayland wasn't working with WSL Arch, so this code
        # should fix that by adding symbolic links to /run/user/1000 to
        # /mnt/wslg/runtime-dir/wayland-0*.
        for src in /mnt/wslg/runtime-dir/wayland-0*; do
            # Check if the source file exists to avoid "no matches found"
            if [ -e "$src" ]; then
                # Extract the filename from the source path
                filename=$(basename "$src")
                target="/run/user/1000/$filename"

                # Only create the symbolic link if the target does not exist
                if [ ! -e "$target" ]; then
                    ln -s "$src" "$target" 2>/dev/null
                fi
            fi
        done
    fi
    if command -v archey &> /dev/null; then
        archey
    fi
elif [[ -f /etc/os-release ]] && grep -qiE 'debian|ubuntu' /etc/os-release; then
    if command -v neofetch &> /dev/null; then
        neofetch
    fi
    if grep -qi 'microsoft' /proc/version; then
        browser_path="$ZDOTDIR/open-browser.sh"
        export BROWSER="$browser_path"
        export PATH="$HOME/.local/bin:$PATH"
        export PYENV_ROOT="$HOME/.pyenv"
        export PATH="$PYENV_ROOT/bin:$PATH"
        if command -v pyenv 1>/dev/null 2>&1; then
            eval "$(pyenv init -)"
        fi
    fi
elif [[ "$(uname -s)" == "Darwin" ]]; then
    export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
    export GEM_HOME="$HOME/.gem"
    export PATH="$HOME/.gem/bin:$PATH"
    if command -v neofetch &> /dev/null; then
        neofetch
    fi
fi

if [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh
fi

