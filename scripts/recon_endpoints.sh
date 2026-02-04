#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: ./recon_endpoints.sh example.com"
  exit 1
fi

TARGET=$1
BASE_DIR="targets/$TARGET"
RECON_DIR="$BASE_DIR/recon"
ENDPOINT_DIR="$BASE_DIR/endpoints"

LIVE="$RECON_DIR/live_hosts.txt"

if [ ! -f "$LIVE" ]; then
  echo "[-] live_hosts.txt not found. Run recon_live_hosts.sh first."
  exit 1
fi

mkdir -p "$ENDPOINT_DIR"

echo "[*] Collecting endpoints using gau"

cat "$LIVE" | gau > "$ENDPOINT_DIR/all_endpoints.txt"

grep "?" "$ENDPOINT_DIR/all_endpoints.txt" | sort -u > "$ENDPOINT_DIR/params.txt"

echo "[+] Total endpoints: $(wc -l < "$ENDPOINT_DIR/all_endpoints.txt")"
echo "[+] Parameterized endpoints: $(wc -l < "$ENDPOINT_DIR/params.txt")"
