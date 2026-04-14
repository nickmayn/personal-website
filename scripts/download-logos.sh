#!/usr/bin/env bash
# Downloads company and school logos from Clearbit into logos/
# Warns but does not fail the pipeline if any logo cannot be downloaded.
set -euo pipefail

mkdir -p logos

declare -A LOGOS=(
  [ironeaglex.png]="https://logo.clearbit.com/ironeaglex.com"
  [boozallen.png]="https://logo.clearbit.com/boozallen.com"
  [mitre.png]="https://logo.clearbit.com/mitre.org"
  [vt.png]="https://logo.clearbit.com/vt.edu"
  [gmu.png]="https://logo.clearbit.com/gmu.edu"
)

FAILED=0

for FILE in "${!LOGOS[@]}"; do
  URL="${LOGOS[$FILE]}"
  DEST="logos/${FILE}"
  if [ -f "$DEST" ]; then
    echo "Using cached $FILE"
  else
    if curl -sf --max-time 10 "$URL" -o "$DEST"; then
      echo "Downloaded $FILE"
    else
      echo "ERROR: Failed to download $FILE from $URL" >&2
      FAILED=1
    fi
  fi
done

if [ "$FAILED" -ne 0 ]; then
  echo "Warning: one or more logos could not be downloaded. The site will deploy without them." >&2
fi
