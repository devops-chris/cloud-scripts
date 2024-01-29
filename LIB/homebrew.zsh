function install_brewfile_packages () {
  read -k1 "install?Install or update required packages? RECOMMENDED (y/n): "
  if [[ ${install} =~ ^[Yy]$ ]]; then
    echo "\nInstalling/updating required packages via Homebrew..."
    brew bundle install --file="Brewfile"
    echo "\nAll packages are installed and up to date.\n"
  else
    echo
  fi
}
