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

## OS Branches

Platform-independent config is stored in the `master` branch. For os-specific configs/scripts/profiles, switch to one of the platform branches.
