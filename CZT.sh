#!/bin/bash

# Ensure the script is run with a domain argument
if [ -z "$1" ]; then
  echo "Usage: $0 <domain_name>"
  exit 1
fi

DOMAIN="$1"

# Get the authoritative nameservers for the domain
echo "[*] Checking authoritative nameservers for $DOMAIN"
NS_SERVERS=$(dig +short NS $DOMAIN)

if [ -z "$NS_SERVERS" ]; then
  echo "[!] No nameservers found for $DOMAIN."
  exit 1
fi

# Attempt a zone transfer on each nameserver
for NS in $NS_SERVERS; do
  echo "[*] Attempting zone transfer on nameserver: $NS"
  
  # Try zone transfer (AXFR) using dig
  ZONE_TRANSFER=$(dig @$NS $DOMAIN AXFR +short)

  if [ -z "$ZONE_TRANSFER" ]; then
    echo "[!] Zone transfer failed on $NS."
  else
    echo "[*] Zone transfer succeeded on $NS:"
    echo "$ZONE_TRANSFER"
  fi
done
