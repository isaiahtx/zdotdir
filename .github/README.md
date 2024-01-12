# zdotdir

My personal [Antidote](https://github.com/mattmc3/antidote) `$ZDOTDIR` directory. Antidote is a ZSH plugin manager, $ZDOTDIR is where the config files are stored. Running the below code will set up your terminal to look and function exactly like mine (and I think mine looks and works very nicely).

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

[antidote]: https://getantidote.github.io
