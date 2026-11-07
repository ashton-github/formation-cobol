#!/usr/bin/env bash
# Vérifie que GnuCOBOL est installé et que la commande cob fonctionne.
cd "$(dirname "$0")/../workspace" || exit 1
command -v cobc >/dev/null || { echo "[KO] cobc introuvable : installez GnuCOBOL (README.md, section 2)"; exit 1; }
cobc --version | head -1
../scripts/cob seance1/exemples/01_hello.cob && echo "[ OK ] Installation valide"
