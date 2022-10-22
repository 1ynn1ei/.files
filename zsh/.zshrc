# Download Znap, if it's not there yet.
[[ -f ~/Git/zsh-snap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/Git/zsh-snap
source ~/Git/zsh-snap/znap.zsh  # Start Znap
source $HOME/.zshconfig/spectrum.zsh
source $HOME/.zshconfig/theme.zsh
source $HOME/.zshconfig/git.zsh

znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting

export EDITOR=nvim
export VISUAL=nvim

setopt prompt_subst # make theme work
setopt auto_cd      # very convenient

#silly nonsense
_help() { curl -s -L cheat.sh/$@ | less -R }
_weather() { curl -s -L "wttr.in/$@?m&Q" }
_weather_oneline() { curl -s _l "wttr.in/$@?m&format=2" }
_gay() { $1 | lolcat -F 0.3 }

# alias
alias vim=nvim
alias help='_help'
alias weather='_weather'
alias w='_weather_oneline'
alias gay='_gay'
#

# Rust nonsense
export LIBRARY_PATH=$LIBRARY_PATH:$(brew --prefix)/lib:$(brew --prefix)/opt/sdl2/lib
export LIBRARY_PATH=$LIBRARY_PATH:$(brew --prefix)/lib:$(brew --prefix)/opt/sdl2_gfx/lib

w
