# MyZsh
My ZSH configurations

# Installation 

If using SSH, and will contribute to the project, install using:
```
git clone git@github.com:francogp/myzsh.git ~/.myzsh && bash ~/.myzsh/install.sh
```
If just using this scripts, install using:
```
git clone https://github.com/francogp/myzsh.git ~/.myzsh && bash ~/.myzsh/install.sh
```
# Update all scripts and plugins
for update zsh with latest LOCAL modifications, use:
```
uzsh
```
To update all repositories and update local configs, you can use:
```
pzsh
```
# Aliases
```
alias uos='sudo apt update && sudo apt -y upgrade && sudo apt -y autoremove'
alias uzsh='bash ~/.myzsh/update.sh && upgrade_oh_my_zsh && src'
alias pzsh='cd ~/.myzsh && git pull && bash ~/.myzsh/update.sh && upgrade_oh_my_zsh && src'
```