#!/usr/bin/env bash

echo "**** Updating ... ****"
echo "* configs.."
rsync -ahzc "${HOME}/.myzsh/.p10k.zsh" "${HOME}/" || exit 100
rsync -ahzc "${HOME}/.myzsh/.zshrc" "${HOME}/" || exit 100
rsync -ahzc "${HOME}/.myzsh/.nanorc" "${HOME}/" || exit 100
mkdir -p "${HOME}/.config/neofetch/"  || exit 100
rsync -ahzc "${HOME}/.myzsh/neofetch.conf" "${HOME}/.config/neofetch/config.conf" || exit 100
echo "* powerlevel10k.."
git -C ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k pull || exit 100
echo "* autosuggestions.."
git -C ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions pull || exit 100
echo "* highlighting.."
git -C ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting pull || exit 100
echo "* colorsls.."
gem update colorls
echo "* zsh.."

echo "
**************************
if you run manually update.sh, RUN THIS!

upgrade_oh_my_zsh && src
"
