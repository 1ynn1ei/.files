# source $HOME/.zshconfig/antigen.zsh
source $HOME/.zshconfig/theme.zsh
# plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

export EDITOR=nvim
export VISUAL=nvim

#silly nonsense
_help() { curl -s -L cheat.sh/$@ | less -R }
_weather() { curl -s -L "wttr.in/$@?m&Q" }
_weather_oneline() { curl -s _l "wttr.in/$@?m&format=2" }
_gay() { $1 | lolcat -F 0.3 }

# alias
alias help='_help'
alias weather='_weather'
alias w='_weather_oneline'
alias gay='_gay'
#

# Rust nonsense
export LIBRARY_PATH=$LIBRARY_PATH:$(brew --prefix)/lib:$(brew --prefix)/opt/sdl2/lib
export LIBRARY_PATH=$LIBRARY_PATH:$(brew --prefix)/lib:$(brew --prefix)/opt/sdl2_gfx/lib

# antigen apply


w
