#!/bin/zsh
#
# .zshrc - Zsh file loaded on interactive shell sessions.
#
# Extras
export NDOTDIR=${HOME}/.config/nvim
export NSWAPDIR=${HOME}/.local/state/nvim/swap/
export PATH=$PATH:$HOME/go/bin
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
export POETRY_VIRTUALENVS_IN_PROJECT=true
export CLAUDE_CODE_DISABLE_ADAPTIVE_THINKING=1
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

# WSL-specific aliases (any distro)
if grep -qi 'microsoft' /proc/version 2>/dev/null; then
    alias explorer="explorer.exe"
    export COLORTERM=truecolor
    export BROWSER=wslview
fi

if [[ -f /etc/os-release ]] && grep -qi 'Arch' /etc/os-release; then
    local ruby_gem_bin
    ruby_gem_bin=$(ls -d "$HOME/.local/share/gem/ruby"/*/bin 2>/dev/null | sort -V | tail -1)
    [[ -n "$ruby_gem_bin" ]] && export PATH="${PATH}:${ruby_gem_bin}"
    if grep -qi 'microsoft' /proc/version; then
        # For some reason Wayland wasn't working with WSL Arch, so this code
        # should fix that by adding symbolic links to /run/user/1000 to
        # /mnt/wslg/runtime-dir/wayland-0*.
        for src in /mnt/wslg/runtime-dir/wayland-0*; do
            # Check if the source file exists to avoid "no matches found"
            if [ -e "$src" ]; then
                # Extract the filename from the source path
                filename=$(basename "$src")
                target="/run/user/$(id -u)/$filename"
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
    export PATH="$PATH:/snap/bin"
    export PATH="$PATH:/opt/nvim/"
    if grep -qi 'microsoft' /proc/version; then
        # Force GTK apps to use X11 so xdotool can find them (WSLg defaults to Wayland)
        export GDK_BACKEND=x11
        # Start D-Bus session daemon if not running (needed for Zathura/VimTeX)
        if [ ! -S /run/user/$(id -u)/bus ]; then
            dbus-daemon --session --address="unix:path=/run/user/$(id -u)/bus" --fork 2>/dev/null
        fi
        browser_path="$ZDOTDIR/open-browser.sh"
        # export BROWSER="$browser_path"
        export PATH="$HOME/.npm-global/bin:$HOME/.local/bin:$PATH"
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

export NVM_DIR="${NVM_DIR:-${XDG_CONFIG_HOME:-$HOME/.config}/nvm}"
[[ ! -s "$NVM_DIR/nvm.sh" ]] && NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
