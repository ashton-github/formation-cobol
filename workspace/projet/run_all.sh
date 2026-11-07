#!/usr/bin/env bash
# Exécute la SOLUTION complète du mini-projet.
# Usage : ./run_all.sh   (depuis workspace/projet ou ailleurs)
COB="$(cd "$(dirname "$0")/../.." && pwd)/scripts/cob"
cd "$(dirname "$0")" || exit 1
"$COB" solution/charge.cob  || exit 1
"$COB" solution/traite.cob  || exit 1
"$COB" solution/edition.cob || exit 1
./verifier.sh
