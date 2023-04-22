install_if_not_exist() {
  if dpkg -s "$1" &>/dev/null; then
    PKG_EXIST=$(dpkg -s "$1" | grep "install ok installed")
    if [[ -n "$PKG_EXIST" ]]; then
      return
    fi
  fi
  apt install "$1" -y
}

#install_if_not_exist git
#install_if_not_exist zsh
#install_if_not_exist ripgrep
#install_if_not_exist stow
#install_if_not_exist fuse

# default our shell
#chsh -s $(which zsh)

# install neovim
wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod u+x nvim.appimage
mv nvim.appimage ~/.local/bin/nvim

# link up our configs
stow -v -R -t ~/.config config
stow -v -R -t ~ zsh

#zsh

