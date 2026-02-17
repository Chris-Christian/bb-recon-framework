#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: ./generate_report.sh example.com"
  exit 1
fi

TARGET=$1
BASE_DIR="targets/$TARGET"
RECON_DIR="$BASE_DIR/recon"
ENDPOINT_DIR="$BASE_DIR/endpoints"
NOTES_DIR="$BASE_DIR/notes"

REPORT="$BASE_DIR/report.md"

SUBS="$RECON_DIR/subdomains.txt"
LIVE="$RECON_DIR/live_hosts.txt"
ALL_EP="$ENDPOINT_DIR/all_endpoints.txt"
PARAMS="$ENDPOINT_DIR/params.txt"
AUTH="$ENDPOINT_DIR/auth.txt"
API="$ENDPOINT_DIR/api.txt"
UPLOAD="$ENDPOINT_DIR/upload.txt"
REDIRECT="$ENDPOINT_DIR/redirect.txt"
ADMIN="$ENDPOINT_DIR/admin.txt"

# ---------- Safe line counter ----------
count() {
  if [ -f "$1" ]; then
    wc -l < "$1"
  else
    echo 0
  fi
}

# ---------- Execution status detection ----------
SUB_RAN="No"
LIVE_RAN="No"
ENDPOINT_RAN="No"
CHECKLIST_RAN="No"
HYP_RAN="No"

[ -f "$SUBS" ] && SUB_RAN="Yes"
[ -f "$LIVE" ] && LIVE_RAN="Yes"
[ -f "$ALL_EP" ] && ENDPOINT_RAN="Yes"
[ -f "$NOTES_DIR/manual_testing.md" ] && CHECKLIST_RAN="Yes"
[ -f "$NOTES_DIR/hypotheses.md" ] && HYP_RAN="Yes"

# ---------- Start writing report ----------
echo "# Recon Summary – $TARGET" > "$REPORT"
echo "" >> "$REPORT"

echo "## Scope" >> "$REPORT"
echo "- Target: $TARGET" >> "$REPORT"
echo "" >> "$REPORT"

echo "## Execution Status" >> "$REPORT"
echo "- Subdomain enumeration: $SUB_RAN" >> "$REPORT"
echo "- Live host detection: $LIVE_RAN" >> "$REPORT"
echo "- Endpoint discovery: $ENDPOINT_RAN" >> "$REPORT"
echo "- Manual checklist generated: $CHECKLIST_RAN" >> "$REPORT"
echo "- Vulnerability hypotheses generated: $HYP_RAN" >> "$REPORT"
echo "" >> "$REPORT"

echo "## Recon Statistics" >> "$REPORT"
echo "- Subdomains discovered: $(count "$SUBS")" >> "$REPORT"
echo "- Live hosts: $(count "$LIVE")" >> "$REPORT"
echo "- Total endpoints: $(count "$ALL_EP")" >> "$REPORT"
echo "- Parameterized endpoints: $(count "$PARAMS")" >> "$REPORT"
echo "" >> "$REPORT"

echo "## Key Attack Surfaces" >> "$REPORT"
echo "- Auth endpoints: $(count "$AUTH")" >> "$REPORT"
echo "- API endpoints: $(count "$API")" >> "$REPORT"
echo "- Upload endpoints: $(count "$UPLOAD")" >> "$REPORT"
echo "- Redirect endpoints: $(count "$REDIRECT")" >> "$REPORT"
echo "- Admin endpoints: $(count "$ADMIN")" >> "$REPORT"
echo "" >> "$REPORT"

echo "## Generated Notes" >> "$REPORT"

if [ -f "$NOTES_DIR/manual_testing.md" ]; then
  echo "- Manual testing checklist: notes/manual_testing.md" >> "$REPORT"
else
  echo "- Manual testing checklist: Not generated" >> "$REPORT"
fi

if [ -f "$NOTES_DIR/hypotheses.md" ]; then
  echo "- Vulnerability hypotheses: notes/hypotheses.md" >> "$REPORT"
else
  echo "- Vulnerability hypotheses: Not generated" >> "$REPORT"
fi

echo "" >> "$REPORT"

echo "_Report generated automatically by bb-recon-framework_" >> "$REPORT"

echo "[+] Recon summary report generated at $REPORT"