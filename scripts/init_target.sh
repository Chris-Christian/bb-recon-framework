#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: ./init_target.sh example.com"
  exit 1
fi

TARGET=$1
BASE_DIR="targets/$TARGET"

mkdir -p "$BASE_DIR"/{recon,endpoints,notes}

echo "# Recon Report – $TARGET" > "$BASE_DIR/report.md"
echo "[+] Initialized structure for $TARGET"