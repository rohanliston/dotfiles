# ==[ Oh My ZSH Settings ]===================================================================

# Custom command prompt style
ZSH_THEME="rohan-blinks"

# Disable autocorrect prompts
DISABLE_CORRECTION="true"

# Custom plugins to load from ~/.oh-my-zsh/custom/plugins/
plugins=(git github)

# Oh my zsh update frequency (in days)
export UPDATE_ZSH_DAYS=30

# Pull in oh-my-zsh with above settings
source $HOME/.oh-my-zsh/oh-my-zsh.sh


# ==[ ZSH Settings ]=========================================================================

# Appends every command to the history file once it is executed
setopt inc_append_history

# Reloads the history whenever you use it
setopt share_history


# ==[ PATH ]=================================================================================

# Set paths
export PATH=$PATH:$HOME/.local/bin


# ==[ Aliases ]==============================================================================

# Shell aliases
alias zshconfig="vim ~/.zshrc"
alias zshprofile="vim ~/.profile"
alias srcall="source ~/.zshrc && source ~/.profile"
alias sagi="sudo apt install"
alias sagu="sudo apt update"
alias pk="xclip -sel clip < ~/.ssh/id_rsa.pub -f && echo '\nPublic key copied to clipboard.'"

# Path aliases
alias dev="cd ~/Development"
alias proj="dev && cd dstil/serenity"
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


# ==[ Shell Helpers ]========================================================================

# mkdir, cd into it: http://onethingwell.org/post/586977440/mkcd-improved
function mkcd () {
    mkdir -p "$*"
    cd "$*"
}


# ==[ Ruby ]=================================================================================

export PATH=$PATH:$HOME/.rbenv/bin
eval "$(rbenv init - zsh)"


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

# ==[ Local Settings ]=======================================================================

# use .zshrc.local for settings specific to one system
[[ -f "${HOME}/.zshrc.local" ]] && source "${HOME}/.zshrc.local"
