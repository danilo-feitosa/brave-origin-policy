#!/usr/bin/env bash
set -euo pipefail

SOURCE="$(dirname "$(readlink -f "$0")")/brave-origin-policy.json"
TARGET="/etc/brave/policies/managed/brave-origin-policy.json"
BACKUP="/var/lib/brave-origin-policy"

if [[ $EUID -ne 0 ]]; then
    echo "Execute: sudo bash install.sh"
    exit 1
fi

if [[ ! -f "$SOURCE" ]]; then
    echo "JSON não encontrado."
    exit 1
fi

if [[ -e "$BACKUP/receipt" ]]; then
    echo "Instalação já registrada. Execute restore.sh."
    exit 1
fi

python3 -m json.tool "$SOURCE" >/dev/null

mkdir -p "$(dirname "$TARGET")" "$BACKUP"

if [[ -f "$TARGET" ]]; then
    cp -a "$TARGET" "$BACKUP/previous-policy.json"
    echo "had_previous=1" > "$BACKUP/receipt"
else
    echo "had_previous=0" > "$BACKUP/receipt"
fi

install -m 0644 "$SOURCE" "$TARGET.tmp"
mv "$TARGET.tmp" "$TARGET"

echo "Brave Origin Policy instalado!"
echo "Arquivo: $TARGET"
echo "Reinicie o Brave."
