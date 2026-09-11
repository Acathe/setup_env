#!/usr/bin/env bash

set -euo pipefail

CLEAR_API_KEYS="${CLEAR_API_KEYS:-0}"
API_KEY_GENERATION_COUNT="${API_KEY_GENERATION_COUNT:-0}"
API_KEY_TO_ADD="${API_KEY_TO_ADD:-}"
MODEL_MAPPING_KEY="${MODEL_MAPPING_KEY:-}"
MODEL_MAPPING_VALUE="${MODEL_MAPPING_VALUE:-}"

parse_args() {
    POSITIONAL=()
    while (($# > 0)); do
        case "$1" in
            --clear-api-keys | --reset-api-key)
                CLEAR_API_KEYS=1
                shift
                ;;
            --generate-api-keys | --api-keys)
                numOfArgs=1 # number of switch arguments
                if (($# < numOfArgs + 1)); then
                    shift $#
                else
                    API_KEY_GENERATION_COUNT="$2"
                    shift $((numOfArgs + 1)) # shift 'numOfArgs + 1' to bypass switch and its value
                fi
                ;;
            --add-api-key)
                numOfArgs=1 # number of switch arguments
                if (($# < numOfArgs + 1)); then
                    shift $#
                else
                    API_KEY_TO_ADD="$2"
                    shift $((numOfArgs + 1)) # shift 'numOfArgs + 1' to bypass switch and its value
                fi
                ;;
            --model-mapping)
                numOfArgs=2 # 参数值数量
                if (($# < numOfArgs + 1)); then
                    shift $#
                else
                    MODEL_MAPPING_KEY="$2"
                    MODEL_MAPPING_VALUE="$3"
                    shift $((numOfArgs + 1)) # 跳过参数名及其值
                fi
                ;;
            *) # unknown flag/switch
                POSITIONAL+=("$1")
                shift
                ;;
        esac
    done
}

main() {
    if ! command -v docker > /dev/null 2>&1; then
        echo 'Docker is not installed.' >&2
        return 1
    fi

    docker build \
        -qt 'copilot-api-config' \
        '.'

    docker run \
        -q \
        --rm \
        -e "CLEAR_API_KEYS=$CLEAR_API_KEYS" \
        -e "API_KEY_GENERATION_COUNT=$API_KEY_GENERATION_COUNT" \
        -e "API_KEY_TO_ADD=$API_KEY_TO_ADD" \
        -e "MODEL_MAPPING_KEY=$MODEL_MAPPING_KEY" \
        -e "MODEL_MAPPING_VALUE=$MODEL_MAPPING_VALUE" \
        -v "$HOME/.copilot-api:/root/.copilot-api" \
        'copilot-api-config'
}

if [[ $0 == "${BASH_SOURCE[0]}" ]]; then
    cd "$(dirname "${BASH_SOURCE[0]}")"
    parse_args "$@"
    set -- "${POSITIONAL[@]}" # restore positional params
    main "$@"
fi
