#!/usr/bin/env bash

set -e

main() {
    if [ -z "$(command -v zsh)" ]; then
        sudo apt-get update
        sudo apt-get install zsh -y
        sudo apt-get autoremove -y
        sudo apt-get clean
    fi

    # Sync /etc/zsh/zshenv
    {
        echo "source /etc/environment"
        cat /etc/zsh/zshenv
    } >"$HOME/.tmp.zsh"
    sudo mv "$HOME/.tmp.zsh" /etc/zsh/zshenv

    # Sync /etc/zsh/zprofile
    {
        echo "source /etc/profile"
        cat /etc/zsh/zprofile
    } >"$HOME/.tmp.zsh"
    sudo mv "$HOME/.tmp.zsh" /etc/zsh/zprofile

    # Sync /etc/zsh/zshrc
    {
        echo "shopt() {}"
        echo "source /etc/bash.bashrc"
        echo "unset -f shopt"
        cat /etc/zsh/zshrc
    } >"$HOME/.tmp.zsh"
    sudo mv "$HOME/.tmp.zsh" /etc/zsh/zshrc

    # Sync ~/.zlogout
    echo "source ~/.bash_logout" >"$HOME/.zlogout"

    # Sync ~/.zprofile
    echo "source ~/.profile" >"$HOME/.zprofile"

    # Sync ~/.zshrc
    {
        echo "shopt() {}"
        echo "source ~/.bashrc"
        echo "unset -f shopt"
    } >"$HOME/.zshrc"
}

main "$@"
