ZSH=$HOME/.oh-my-zsh
ZSH_THEME="rohan-blinks"
DISABLE_CORRECTION="true"

# Oh my zsh update frequency (in days)
export UPDATE_ZSH_DAYS=30

# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git)

# Shell aliases
alias zshconfig="vim ~/.zshrc"
alias zshprofile="vim ~/.profile"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias srcall="source ~/.zshrc && source ~/.profile"
alias sagi="sudo apt-get install"
alias sagu="sudo apt-get update"
alias pk="xclip -sel clip < ~/.ssh/id_rsa.pub -f && echo '\nPublic key copied to clipboard.'"
alias pissoff="ps -fC"

# Path aliases
alias dev="cd ~/Development"
alias personal="cd ~/Development/personal"
alias dotfiles="cd ~/.dotfiles"

# Vagrant aliases
alias vup="vagrant up"
alias vdown="vagrant suspend"
alias vp="vagrant provision"
alias vr="vagrant reload"
alias vssh="vagrant ssh"

# App aliases
alias treemap=ncdu

# PATH
export PATH=$PATH:$HOME/.local/bin

# rbenv
export PATH=$PATH:$HOME/.rbenv/bin
eval "$(rbenv init - zsh)"

source $ZSH/oh-my-zsh.sh
