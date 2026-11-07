# Séance 5 — TP5.1 : Chasse aux bugs (35 min)

Trois programmes compilent sans erreur mais produisent de mauvais résultats.
Pour chacun : 1) lancer, 2) décrire le symptôme, 3) formuler une hypothèse,
4) corriger, 5) vérifier avec le résultat attendu écrit en tête du fichier.

Outils à utiliser : `DISPLAY` de contrôle, `cob -d` (contrôles à l'exécution),
relecture des clauses `PIC`, test des cas limites.

| Fichier | Symptôme | Piste |
| --- | --- | --- |
| `bug1.cob` | Somme et moyenne fausses | Plusieurs causes superposées : corrigez-en une, relancez, cherchez la suivante |
| `bug2.cob` | Totaux par région incohérents, une région manque | Regardez le schéma de la rupture de contrôle |
| `bug3.cob` | Texte parasite et comportement bizarre en fin de boucle | Essayez `cob -d` |

Les corrigés commentés sont dans `seance5/corriges/`.

Défi : écrire un jeu de tests (comme `03_tests/test_calc.cob`) qui aurait détecté chacun de ces bugs.
