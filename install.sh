install_if_not_exist() {
  if dpkg -s "$1" &>/dev/null; then
    PKG_EXIST=$(dpkg -s "$1" | grep "install ok installed")
    if [[ -n "$PKG_EXIST" ]]; then
      return
    fi
  fi
  apt install "$1" -y
}

install_if_not_exist git
install_if_not_exist ripgrep
install_if_not_exist stow
# etc 
stow -v -R -t ~/.config config
