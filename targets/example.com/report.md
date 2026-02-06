# Recon Report – example.com

## Subdomain Enumeration
- Tool: subfinder
- Output: recon/subdomains.txt

## Live Host Detection
- Tool: httpx
- Input: recon/subdomains.txt
- Output: recon/live_hosts.txt

## Endpoint Discovery
- Tool: gau
- Input: recon/live_hosts.txt
- Outputs:
  - endpoints/all_endpoints.txt
  - endpoints/params.txt

## Endpoint Categorization
Endpoints grouped by attack surface:
- Auth → auth.txt
- API → api.txt
- Upload → upload.txt
- Redirect → redirect.txt
- Admin → admin.txt
