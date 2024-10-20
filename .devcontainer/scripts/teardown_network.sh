#!/usr/bin/env bash
set -euo pipefail

docker network rm "${SUBNET_NAME}"
docker network rm "${SUBNET2_NAME}"
