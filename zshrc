# ==[ Oh My ZSH Settings ]===================================================================

ZSH=$HOME/.oh-my-zsh

# Custom command prompt style
ZSH_THEME="rohan-blinks"

# Disable autocorrect prompts
DISABLE_CORRECTION="true"

# Custom plugins to load from ~/.oh-my-zsh/custom/plugins/
plugins=(git github)

# Oh my zsh update frequency (in days)
export UPDATE_ZSH_DAYS=30

# Pull in oh-my-zsh with above settings
. $ZSH/oh-my-zsh.sh

# ==[ ZSH Settings ]=========================================================================

# Appends every command to the history file once it is executed
setopt inc_append_history

# Reloads the history whenever you use it
setopt share_history

# Disable auto cd (allows you to cd into directory without using cd command)
unsetopt auto_cd

# ==[ PATH ]=================================================================================

# Set paths
export PATH=$PATH:$HOME/.local/bin:$HOME/.poetry/bin

# ==[ Aliases ]==============================================================================

# Shell aliases
alias zshrc="vim ~/.dotfiles/zshrc"
alias zprofile="vim ~/.dotfiles/zprofile"
alias sagi="sudo apt install"
alias sagu="sudo apt update"
alias pk="xclip -sel clip < ~/.ssh/id_rsa.pub -f && echo '\nPublic key copied to clipboard.'"
alias ls="/bin/ls --color=tty -F"
alias sl="ls"

# Path aliases
alias dev="cd ~/Development"
alias personal="dev && cd personal"
alias dotfiles="cd ~/.dotfiles"
alias dl="cd ~/Downloads"

# AWS/Amplify aliases
alias am="amplify mock"
alias rmam="rm -rf ./amplify/mock-data"

# ==[ Shell Helpers ]========================================================================

# mkdir, cd into it
mkcd() {
    mkdir -p "$*"
    cd "$*"
}

# wo == 'work on': https://coderwall.com/p/feoi0a/shell-cd-replacement
wo() {
  code_dir=~/Development
  dir=$(find $code_dir -maxdepth 3 -type d | grep -i $* | grep -Ev Pods --max-count=1)
  [[ -d $dir ]] && cd $dir
}

# Grep in history
hgrep() { history | grep -i $1 }

# Grep in pip packages
pipgrep() { pip3 freeze | grep -i $1 }

# ==[ Git ]==================================================================================

# Check if branch exists remotely
bgrep() { git branch -r | grep -i $1 }

# ==[ Colours ]==============================================================================

# Colourised man pages: http://boredzo.org/blog/archives/2016-08-15/colorized-man-pages-understood-and-customized
man() {
    env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ==[ Local Settings ]=======================================================================

# use .zshrc.local for settings specific to one system
[[ -f "${HOME}/.zshrc.local" ]] && . "${HOME}/.zshrc.local"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
