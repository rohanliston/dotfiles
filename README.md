# Dotfiles

My curated set of dotfiles, managed using ThoughtBot's [rcm](https://github.com/thoughtbot/rcm).

## Installation

### Ubuntu

```
git clone https://github.com/rohanliston/dotfiles.git ~/.dotfiles
sudo add-apt-repository ppa:martin-frost/thoughtbot-rcm
sudo apt-get update
sudo apt-get install rcm
rcup -df ~/.dotfiles
```

### OSX

```
git clone git@github.com:rohanliston/dotfiles.git ~/.dotfiles
brew tap thoughtbot/formulae
brew install rcm
rcup -df ~/.dotfiles
```

## Local and OS-dependent config

Some files pull in additional 'suffixed' files to add configuration specific to one particular OS or machine. The convention is as follows:

* `.filerc`: Common configuration that works across all OSs/machines
* `.filerc.ubuntu`: Ubuntu-specific config
* `.filerc.osx`: OSX-specific config
* `.filerc.local`: Machine-specific config

This _could_ be managed with platform branches to keep the home directory free of benign files intended for other OSs, but the above is easier to manage with the current level of complexity.
