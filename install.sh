#!/usr/bin/env bash
# made by francogp
OLD_UBUNTU=false
if lsb_release -a | grep -q "18.04"; then
  echo "Old ubuntu detected"
  OLD_UBUNTU=true
fi

echo "**** Installing... ****"
sudo apt update && sudo apt install -y curl zsh rsync fonts-powerline ruby ruby-dev build-essential && sudo gem install rubygems-update && sudo gem update --system && sudo gem install colorls || exit 100

# fix for old ubuntu fzf
if [ "${OLD_UBUNTU}" = true ]; then
  echo "* Applying old ubuntu patches"
  sudo gem update --system 3.0.6 && sudo gem install colorls && sudo gem pristine rake || exit 100
  if [ ! -d "${HOME}/.fzf" ]; then
    echo "* fzf not found, trying to install..."
    git clone --depth 1 https://github.com/junegunn/fzf.git "${HOME}/.fzf" || exit 100
  fi
  "${HOME}"/.fzf/install || exit 100
else
  sudo apt install -y fzf || exit 100
fi

# removing old files
sudo rm -rf "${HOME}/.oh-my-zsh" || exit 100
read -p "***=== Press enter, then type 'exit' and enter, after next prompt!. ===*** " CONT
cd "${HOME}" && sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" || exit 100
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/themes/powerlevel10k" || exit 100
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" || exit 100
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" || exit 100

bash "${HOME}/.myzsh/update.sh" || exit 100

echo "**** Configuring... ****"

chsh -s "$(which zsh)"  || exit 100

if grep -iq Microsoft /proc/version; then
  fc-cache -f -v || exit 100
  echo ""
  echo "************************  DONE  **********************************"
  echo "* Ubuntu on Windows detected *"
  echo "*** Install this fonts MANUALLY ***"
  echo "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/JetBrainsMono/Regular/complete/JetBrains%20Mono%20Regular%20Nerd%20Font%20Complete%20Mono%20Windows%20Compatible.ttf"
  echo "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/JetBrainsMono/Regular/complete/JetBrains%20Mono%20Regular%20Nerd%20Font%20Complete%20Windows%20Compatible.ttf"
  echo "**** Configure terminal to use this fonts: 'JetBrainsMono NF' ****"
  echo "**** Configure editors to use this font: 'JetBrainsMono NF' ****"
else
  mkdir -p "${HOME}/.local/share/fonts" || exit 100
  cd "${HOME}/.local/share/fonts" && wget "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/JetBrainsMono/Regular/complete/JetBrains%20Mono%20Regular%20Nerd%20Font%20Complete%20Mono.ttf" || exit 100
  cd "${HOME}/.local/share/fonts" && wget "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/JetBrainsMono/Regular/complete/JetBrains%20Mono%20Regular%20Nerd%20Font%20Complete.ttf" || exit 100
  fc-cache -f -v || exit 100
  echo ""
  echo "************************  DONE  **********************************"
  echo "**** Configure terminal to use this fonts: 'JetBrainsMono Nerd Font Mono Regular' ****"
  echo "**** Configure editors to use this font: 'JetBrainsMono Nerd Font' ****"
fi

echo "**** RESTART TERMINAL! ****"
