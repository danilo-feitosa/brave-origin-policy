#!/usr/bin/env bash
set -euo pipefail

FILE="/etc/brave/policies/managed/brave-origin-policy.json"

if [[ ! -f "$FILE" ]]; then
    echo "Política não encontrada."
    exit 1
fi

python3 -m json.tool "$FILE"
echo "JSON válido. Confira também brave://policy."
