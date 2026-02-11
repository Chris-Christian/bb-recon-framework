#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: ./generate_hypotheses.sh example.com"
  exit 1
fi

TARGET=$1
BASE_DIR="targets/$TARGET"
ENDPOINT_DIR="$BASE_DIR/endpoints"
NOTES_DIR="$BASE_DIR/notes"

mkdir -p "$NOTES_DIR"

OUT="$NOTES_DIR/hypotheses.md"

PARAMS="$ENDPOINT_DIR/params.txt"
AUTH="$ENDPOINT_DIR/auth.txt"
API="$ENDPOINT_DIR/api.txt"
UPLOAD="$ENDPOINT_DIR/upload.txt"
REDIRECT="$ENDPOINT_DIR/redirect.txt"
ADMIN="$ENDPOINT_DIR/admin.txt"

echo "# Vulnerability Hypotheses – $TARGET" > "$OUT"
echo "" >> "$OUT"

if [ -s "$PARAMS" ]; then
  echo "## Injection & XSS" >> "$OUT"
  echo "- Presence of parameterized endpoints suggests testing for XSS, SQLi, and input validation issues." >> "$OUT"
  echo "" >> "$OUT"
fi

if [ -s "$AUTH" ]; then
  echo "## Authentication & Logic Flaws" >> "$OUT"
  echo "- Authentication-related endpoints detected. Test for login bypass, weak reset flows, and session issues." >> "$OUT"
  echo "" >> "$OUT"
fi

if [ -s "$API" ]; then
  echo "## IDOR & Access Control" >> "$OUT"
  echo "- API endpoints present. High likelihood of IDOR, broken object-level authorization, and privilege escalation." >> "$OUT"
  echo "" >> "$OUT"
fi

if [ -s "$UPLOAD" ]; then
  echo "## File Upload Vulnerabilities" >> "$OUT"
  echo "- Upload-related endpoints found. Test for file type bypass, stored XSS, and path traversal." >> "$OUT"
  echo "" >> "$OUT"
fi

if [ -s "$REDIRECT" ]; then
  echo "## Open Redirect / SSRF" >> "$OUT"
  echo "- Redirect parameters detected. Check for open redirect and SSRF possibilities." >> "$OUT"
  echo "" >> "$OUT"
fi

if [ -s "$ADMIN" ]; then
  echo "## Admin Panel Exposure" >> "$OUT"
  echo "- Admin-related endpoints discovered. Test for authorization bypass and sensitive access exposure." >> "$OUT"
  echo "" >> "$OUT"
fi

echo "[+] Hypotheses generated at $OUT"