#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: ./run_all.sh example.com"
  exit 1
fi

TARGET=$1

echo "=============================="
echo "  bb-recon-framework runner"
echo "  Target: $TARGET"
echo "=============================="

# ---------- Step 1: Init ----------
if [ ! -d "targets/$TARGET" ]; then
  echo "[*] Initializing target..."
  ./scripts/init_target.sh "$TARGET"
else
  echo "[=] Target already initialized"
fi

# ---------- Step 2: Subdomains ----------
if [ ! -f "targets/$TARGET/recon/subdomains.txt" ]; then
  echo "[*] Running subdomain enumeration..."
  ./scripts/recon_subdomains.sh "$TARGET"
else
  echo "[=] Subdomains already collected"
fi

# ---------- Step 3: Live hosts ----------
if [ ! -f "targets/$TARGET/recon/live_hosts.txt" ]; then
  echo "[*] Detecting live hosts..."
  ./scripts/recon_live_hosts.sh "$TARGET"
else
  echo "[=] Live hosts already detected"
fi

# ---------- Step 4: Endpoints ----------
if [ ! -f "targets/$TARGET/endpoints/all_endpoints.txt" ]; then
  echo "[*] Discovering endpoints..."
  ./scripts/recon_endpoints.sh "$TARGET"
else
  echo "[=] Endpoints already collected"
fi

# ---------- Step 5: Categorization ----------
if [ ! -f "targets/$TARGET/endpoints/api.txt" ]; then
  echo "[*] Categorizing endpoints..."
  ./scripts/categorize_endpoints.sh "$TARGET"
else
  echo "[=] Endpoints already categorized"
fi

# ---------- Step 6: Checklist ----------
if [ ! -f "targets/$TARGET/notes/manual_testing.md" ]; then
  echo "[*] Generating manual testing checklist..."
  ./scripts/generate_checklist.sh "$TARGET"
else
  echo "[=] Checklist already generated"
fi

# ---------- Step 7: Hypotheses ----------
if [ ! -f "targets/$TARGET/notes/hypotheses.md" ]; then
  echo "[*] Generating vulnerability hypotheses..."
  ./scripts/generate_hypotheses.sh "$TARGET"
else
  echo "[=] Hypotheses already generated"
fi

# ---------- Step 8: Final Report ----------
echo "[*] Generating final recon report..."
./scripts/generate_report.sh "$TARGET"

echo ""
echo "[+] Recon pipeline completed for $TARGET"
echo "Report: targets/$TARGET/report.md"