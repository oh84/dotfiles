#!/bin/bash
echo "💰 \$$(npx ccusage monthly --json --offline --order desc | jq -r '.monthly[0].totalCost * 100 | round / 100') monthly"
