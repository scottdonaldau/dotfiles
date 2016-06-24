## fresh machine - install git !

    sudo apt-get install git

on a Mac, go brew
```
ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"
brew update
brew upgrade
brew install git

```

## Installation

```
git clone git@github.com:jobwat/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
git submodule update --init
rake install
```

## Later usage

### Changing shells:

    chsh -s /bin/zsh

or back to bash:

    chsh -s /bin/bash


### Vim-PLug

    vim plugins are managed through vimrc itself now, see https://github.com/junegunn/vim-plug

### Update

    rake update

### Acknowledgements

Thanks to [Rufus Post]( http://github.com/mynameisrufus/dotfiles) for the dotfiles idea !

And thx to all the coders that make this possible through their code share: [gmarik](https://github.com/gmarik/Vundle.vim), [Tim Pope](https://github.com/tpope), [Robby Russell](https://github.com/robbyrussell/oh-my-zsh) and so many more.

