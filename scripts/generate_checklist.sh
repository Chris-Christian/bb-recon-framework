#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: ./generate_checklist.sh example.com"
  exit 1
fi

TARGET=$1
BASE_DIR="targets/$TARGET"
ENDPOINT_DIR="$BASE_DIR/endpoints"
NOTES_DIR="$BASE_DIR/notes"

mkdir -p "$NOTES_DIR"

CHECKLIST="$NOTES_DIR/manual_testing.md"

echo "# Manual Testing Checklist – $TARGET" > "$CHECKLIST"
echo "" >> "$CHECKLIST"

echo "## Authentication Testing" >> "$CHECKLIST"
echo "- [ ] Test login for SQL Injection" >> "$CHECKLIST"
echo "- [ ] Check password reset flow for logic flaws" >> "$CHECKLIST"
echo "- [ ] Test account lockout / brute force protection" >> "$CHECKLIST"
echo "- [ ] Test session fixation / session reuse" >> "$CHECKLIST"
echo "" >> "$CHECKLIST"

echo "## IDOR / Access Control" >> "$CHECKLIST"
echo "- [ ] Test IDOR on API endpoints" >> "$CHECKLIST"
echo "- [ ] Modify user IDs / object IDs" >> "$CHECKLIST"
echo "- [ ] Check horizontal & vertical privilege escalation" >> "$CHECKLIST"
echo "" >> "$CHECKLIST"

echo "## Input & Injection" >> "$CHECKLIST"
echo "- [ ] Test parameters for XSS" >> "$CHECKLIST"
echo "- [ ] Test parameters for SQLi" >> "$CHECKLIST"
echo "- [ ] Test command injection / SSTI if applicable" >> "$CHECKLIST"
echo "" >> "$CHECKLIST"

echo "## File Upload" >> "$CHECKLIST"
echo "- [ ] Try file type bypass (php, svg, html)" >> "$CHECKLIST"
echo "- [ ] Check for stored XSS via upload" >> "$CHECKLIST"
echo "- [ ] Test file overwrite / path traversal" >> "$CHECKLIST"
echo "" >> "$CHECKLIST"

echo "## Redirect & SSRF" >> "$CHECKLIST"
echo "- [ ] Test open redirect parameters" >> "$CHECKLIST"
echo "- [ ] Check SSRF via URL-based inputs" >> "$CHECKLIST"
echo "" >> "$CHECKLIST"

echo "[+] Manual testing checklist generated at $CHECKLIST"