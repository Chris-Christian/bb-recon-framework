#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: ./categorize_endpoints.sh example.com"
  exit 1
fi

TARGET=$1
BASE_DIR="targets/$TARGET"
ENDPOINT_DIR="$BASE_DIR/endpoints"

ALL="$ENDPOINT_DIR/all_endpoints.txt"

if [ ! -f "$ALL" ]; then
  echo "[-] all_endpoints.txt not found. Run recon_endpoints.sh first."
  exit 1
fi

echo "[*] Categorizing endpoints..."

grep -Ei "login|signin|auth|account|password|reset" "$ALL" | sort -u > "$ENDPOINT_DIR/auth.txt"

grep -Ei "/api/|/v1/|/v2/|json|graphql" "$ALL" | sort -u > "$ENDPOINT_DIR/api.txt"

grep -Ei "upload|file|attachment|import" "$ALL" | sort -u > "$ENDPOINT_DIR/upload.txt"

grep -Ei "redirect=|url=|next=|return=" "$ALL" | sort -u > "$ENDPOINT_DIR/redirect.txt"

grep -Ei "admin|dashboard|manage|panel" "$ALL" | sort -u > "$ENDPOINT_DIR/admin.txt"

echo "[+] Auth endpoints: $(wc -l < "$ENDPOINT_DIR/auth.txt")"
echo "[+] API endpoints: $(wc -l < "$ENDPOINT_DIR/api.txt")"
echo "[+] Upload endpoints: $(wc -l < "$ENDPOINT_DIR/upload.txt")"
echo "[+] Redirect endpoints: $(wc -l < "$ENDPOINT_DIR/redirect.txt")"
echo "[+] Admin endpoints: $(wc -l < "$ENDPOINT_DIR/admin.txt")"