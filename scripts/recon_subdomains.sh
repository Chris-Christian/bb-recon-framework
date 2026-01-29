#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: ./recon_subdomains.sh example.com"
  exit 1
fi

TARGET=$1
BASE_DIR="targets/$TARGET"
OUT_DIR="$BASE_DIR/recon"

if [ ! -d "$BASE_DIR" ]; then
  echo "[-] Target not initialized. Run init_target.sh first."
  exit 1
fi

echo "[*] Running subfinder on $TARGET"

subfinder -d "$TARGET" -silent > "$OUT_DIR/subdomains.txt"

COUNT=$(wc -l < "$OUT_DIR/subdomains.txt")
echo "[+] Found $COUNT subdomains"