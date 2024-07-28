#!/usr/bin/env bash
#
# Respects the following environment variables:
#   ENABLE_CHINA_MIRROR -
#   DISENABLE_TOOL      -
#   DISENABLE_LANG      -
#

set -e

main() {
    if [ -n "$ENABLE_CHINA_MIRROR" ]; then
        export ENABLE_CHINA_MIRROR=1
    fi

    if [ -z "$DISENABLE_TOOL" ]; then
        bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/master/tool/apt.sh")"
        bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/master/tool/zsh.sh")"
        bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/master/tool/omz.sh")"
        bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/master/tool/omz_plugins.sh")"
    fi

    if [ -z "$DISENABLE_LANG" ]; then
        bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/master/lang/cpp.sh")"
        # bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/master/lang/golang.sh")"
        bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/master/lang/rust.sh")"
        bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/master/lang/python.sh")"
    fi

    unset ENABLE_CHINA_MIRROR
}

main "$@"
