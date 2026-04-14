#!/usr/bin/env bash
# Downloads company and school logos into logos/
# Warns but does not fail the pipeline if any logo cannot be downloaded.
set -euo pipefail

CURL_OPTS=(-sf --max-time 20 -L -A "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36")

mkdir -p logos

declare -A LOGOS=(
  [ironeaglex.png]="https://media.licdn.com/dms/image/v2/D4D0BAQH0yB1oOYysbQ/company-logo_200_200/B4DZ0cbBQ6GsAI-/0/1774298338685/ironeaglex_logo?e=1777507200&v=beta&t=d41tAW_Vvxo-r9SStlkUAdytpvEsVTZ1bWtJq-KTuJA"
  [boozallen.png]="https://1000logos.net/wp-content/uploads/2024/05/Booz-Allen-Hamilton-Emblem.png"
  [mitre.png]="https://upload.wikimedia.org/wikipedia/commons/thumb/d/d3/Mitre_Corporation_logo.svg/960px-Mitre_Corporation_logo.svg.png"
  [vt.png]="https://1000logos.net/wp-content/uploads/2018/10/Virginia-Tech-Logo.png"
  [gmu.png]="https://1000logos.net/wp-content/uploads/2019/10/George-Mason-Patriots-Logo-2012-1536x864.png"
)

FAILED=0

for FILE in "${!LOGOS[@]}"; do
  URL="${LOGOS[$FILE]}"
  DEST="logos/${FILE}"
  if [ -f "$DEST" ]; then
    echo "Using cached $FILE"
  else
    if curl "${CURL_OPTS[@]}" "$URL" -o "$DEST"; then
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
