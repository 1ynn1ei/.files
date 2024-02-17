[[ -f ~/git/zsh-snap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/git/zsh-snap

source ~/git/zsh-snap/znap.zsh  # Start Znap
source $HOME/.config/zsh/spectrum.zsh
source $HOME/.config/zsh/theme.zsh
source $HOME/.config/zsh/git.zsh

znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting

export EDITOR=nvim
export VISUAL=nvim
export PATH=$PATH:$HOME/.scripts
export PATH=$PATH:$HOME/.cargo/bin
export SHELL=/usr/bin/zsh

setopt prompt_subst # make theme work
setopt auto_cd      # very convenient

_help() { curl -s -L cheat.sh/$@ | less -R }
_gifify() { gifski --fps 20 -o $2.gif $1 }

eza_params=('--icons' '--classify' '--group-directories-first' '--group')
# alias
alias szh='source ~/.zshrc'
alias vim=nvim
alias help='_help'
alias gifify='_gifify'
alias l='eza $eza_params'
alias ll='eza --all --header --long $eza_params'
alias lx='eza -lbhHigUmuSa'
alias lt='eza --tree --git-ignore'
alias c='clear'
