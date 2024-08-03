#!/usr/bin/env bash

readonly SETUP_TERMINALS_HOMEBREW=1
readonly SETUP_TERMINALS_OMZ=1
readonly INSTALL_APPLICATIONS_ORBSTACK=1
readonly INSTALL_APPLICATIONS_VSCODE=1

option::_() {
    local _="${SETUP_TERMINALS_HOMEBREW}"
    local _="${SETUP_TERMINALS_OMZ}"
    local _="${INSTALL_APPLICATIONS_ORBSTACK}"
    local _="${INSTALL_APPLICATIONS_VSCODE}"
}
