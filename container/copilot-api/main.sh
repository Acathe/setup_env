#!/usr/bin/env bash

set -euo pipefail

COPILOT_API_AUTH="${COPILOT_API_AUTH:-0}"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

parse_args() {
    POSITIONAL=()
    while (($# > 0)); do
        case "$1" in
            --copilot-api-auth)
                COPILOT_API_AUTH=1
                shift
                ;;
            *) # unknown flag/switch
                POSITIONAL+=("$1")
                shift
                ;;
        esac
    done
}

deploy() (
    mkdir -p '/tmp/copilot-api'
    cd '/tmp/copilot-api'

    curl -fsSL 'https://raw.githubusercontent.com/caozhiyuan/copilot-api/dev/docker-compose.yaml' \
        -o './docker-compose.yaml'

    mkdir -p "$HOME/.copilot-data"
    export COPILOT_API_DATA_DIR="$HOME/.copilot-data"

    docker compose pull -q

    if [[ $COPILOT_API_AUTH == '1' ]]; then
        docker compose run --rm 'copilot-api' --auth login < /dev/tty
    fi

    docker compose up -d
)

install_update() {
    install -Dm 644 './98-copilot-api.zsh' \
        "$ZSH_CUSTOM/plugins/update-all-in-one/custom/98-copilot-api.zsh"
}

main() {
    deploy
    install_update
}

if [[ $0 == "${BASH_SOURCE[0]}" ]]; then
    cd "$(dirname "${BASH_SOURCE[0]}")"
    parse_args "$@"
    set -- "${POSITIONAL[@]}" # restore positional params
    main "$@"
fi
