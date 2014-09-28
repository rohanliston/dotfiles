# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="rohan-blinks"

# Aliases
alias zshconfig="vim ~/.zshrc"
alias zshprofile="vim ~/.profile"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias srczshrc="source ~/.zshrc"
alias dev="~/Development"

# Vagrant aliases
alias vup="vagrant up"
alias vdown="vagrant suspend"
alias vp="vagrant provision"
alias vr="vagrant reload"
alias vssh="vagrant ssh"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Oh my zsh update frequency (in days)
export UPDATE_ZSH_DAYS=30

# Disables command autocorrection
DISABLE_CORRECTION="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git rails)

# rbenv
export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init - zsh)"

source $ZSH/oh-my-zsh.sh

# added by travis gem
[ -f /Users/rohan/.travis/travis.sh ] && source /Users/rohan/.travis/travis.sh
