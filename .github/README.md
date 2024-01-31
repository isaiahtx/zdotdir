# zdotdir

My personal [Antidote](https://github.com/mattmc3/antidote) $ZDOTDIR directory.

Antidote is a ZSH plugin manager, $ZDOTDIR is where the config files are
stored. Running the below code will set up your terminal to look and function
exactly like mine (and I think mine looks and works very nicely).

The most important files here are `.zshrc` and `.zsh_plugins.txt`. The file
`.zshrc` runs every time you open a new terminal window, and contains all the
configuration information and the code to keep Antidote installed and up to
date. The file `.zsh_plugins.txt` contains all the `zsh` plugins I have
installed.

**Note:** For those not on Arch, you will want to remove the line labelled
`archey` in [.zshrc](.zshrc)

## Installation

Install ZSH and then run the below code.

```zsh
# clone this project
ZDOTDIR=~/.config/zsh
git clone https://github.com/isaiahtx/zdotdir.git $ZDOTDIR

# symlink .zshenv
[[ -f ~/.zshenv ]] && mv -f ~/.zshenv ~/.zshenv.bak
ln -s $ZDOTDIR/.zshenv ~/.zshenv

# start a new zsh session
zsh
```

Note: this will replace your current `~/.zshenv` with a symlink to a new one. The old config file and will be renamed to `~/.zhsenv.bak`.
