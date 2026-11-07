#!/usr/bin/env bash
# Compare vos sorties au résultat attendu (fichier de rejets exact + contrôle visuel du résumé).
cd "$(dirname "$0")" || exit 1
echo
echo "=== VERIFICATION ==="
if [ ! -f out/rejets.txt ]; then echo "out/rejets.txt absent : lancez d'abord charge puis traite"; exit 1; fi
if diff -b out/rejets.txt attendu/rejets.txt > /dev/null; then
  echo "[ OK ] rejets.txt identique au fichier attendu (11 rejets)"
else
  echo "[ECART] rejets.txt different de attendu/rejets.txt :"
  diff -b out/rejets.txt attendu/rejets.txt
fi
echo "Comparez ensuite votre relevé (out/releve.txt) avec attendu/resume.txt"
