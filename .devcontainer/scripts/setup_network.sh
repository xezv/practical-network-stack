#!/usr/bin/env bash
set -euo pipefail

PREV_DIR="$(pwd)"

CURRENT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
PARENT_DIR=$(cd "${CURRENT_DIR}/.." && pwd)
cd "${PREV_DIR}"

# if not found .env in current directory, exit with error
echo "PREV_DIR: ${PREV_DIR}"
echo "CURRENT_DIR: ${CURRENT_DIR}"
echo "PARENT_DIR: ${PARENT_DIR}"

if [[ ! -f "${PARENT_DIR}/.env" ]]; then
    echo "Not found .env in ${PARENT_DIR}"
    exit 1
fi
source "${PARENT_DIR}/.env"

setup_network() {
    local network_name=$1
    local subnet_cidr=$2
    local gateway_addr=$3
    # if docker network already exists, exit with success
    if docker network ls --format '{{.Name}}' | grep -q "^$network_name$"; then
        echo "docker network $network_name already exists"
        exit 0
    fi

    # or create docker network
    docker network create \
        --driver bridge \
        --subnet "${subnet_cidr}" \
        --gateway "${gateway_addr}" \
        "${network_name}"

    # --ip-range "${SUBNET_BITS}.${}/24" \

    # send stderr to stdout
    # stdout already redirected to `/dev/null`
    # so the stderr also is going to be redirected to `/dev/null`
    # so it's a logic that drop both `stdout`, and `stderr`
    while ! docker network inspect "$network_name" >/dev/null 2>&1; do
        sleep 0.1
    done

    echo "docker network $network_name created"
}

setup_network "${SUBNET_NAME}" "${SUBNET_CIDR}" "${GATEWAY_ADDR}"
setup_network "${SUBNET2_NAME}" "${SUBNET2_CIDR}" "${GATEWAY2_ADDR}"
