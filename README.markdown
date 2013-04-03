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


### Adding a plugin

    git submodule add https://github.com/user/vim-myplugin.git vim/bundle/vim-myplugin

### Updating plugins

    rake update

### Acknowledgements

Thanks to [Ryan Bates]( http://github.com/ryanb/dotfiles) for the Rakefile code, [James Sadler](http://github.com/freshtonic/dotfiles) for the pathogen and bundle ideas, [Zach Holman](https://github.com/holman/dotfiles.git) and many others for their brilliant ideas :)

