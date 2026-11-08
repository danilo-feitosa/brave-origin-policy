#!/usr/bin/env bash
set -euo pipefail

TARGET="/etc/brave/policies/managed/brave-origin-policy.json"
BACKUP="/var/lib/brave-origin-policy"

if [[ $EUID -ne 0 ]]; then
    echo "Execute: sudo bash restore.sh"
    exit 1
fi

if [[ ! -f "$BACKUP/receipt" ]]; then
    echo "Backup não encontrado."
    exit 1
fi

source "$BACKUP/receipt"

if [[ "$had_previous" == "1" ]]; then
    if [[ ! -f "$BACKUP/previous-policy.json" ]]; then
        echo "Backup anterior ausente. Restauração cancelada."
        exit 1
    fi

    install -m 0644 "$BACKUP/previous-policy.json" "$TARGET"
else
    rm -f "$TARGET"
fi

rm -rf "$BACKUP"

echo "Configurações anteriores restauradas!"
echo "Reinicie o Brave."
