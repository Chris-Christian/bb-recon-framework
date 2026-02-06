#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: ./recon_live_hosts.sh example.com"
  exit 1
fi

TARGET=$1
BASE_DIR="targets/$TARGET"
RECON_DIR="$BASE_DIR/recon"

SUBS="$RECON_DIR/subdomains.txt"
OUT="$RECON_DIR/live_hosts.txt"

if [ ! -f "$SUBS" ]; then
  echo "[-] subdomains.txt not found. Run recon_subdomains.sh first."
  exit 1
fi

echo "[*] Checking live hosts with httpx"

cat "$SUBS" | ~/go/bin/httpx -silent > "$OUT"

COUNT=$(wc -l < "$OUT")
echo "[+] Found $COUNT live hosts"