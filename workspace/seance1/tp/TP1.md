# Séance 1 — Travaux pratiques

Rappel : on lance toujours les commandes depuis le dossier `workspace` de la formation.
Créez vos programmes dans `seance1/tp/` (ex. `seance1/tp/tp1_1.cob`) puis lancez
`cob seance1/tp/tp1_1.cob`.

---

## TP1.1 — Carte de visite (20 min) · niveau guidé

Écrire un programme qui affiche une carte de visite encadrée :

```
****************************************
* Jean DUPONT
* Développeur COBOL
* Lyon - 06 12 34 56 78
****************************************
```

Consignes
1. Déclarer en WORKING-STORAGE : nom, prénom, métier, ville, téléphone (avec `VALUE`).
2. Déclarer une ligne de séparation `PIC X(40) VALUE ALL "*"`.
3. Afficher la carte avec plusieurs `DISPLAY`.

Bonus : changer la ville sans toucher aux DISPLAY (seulement la VALUE).

---

## TP1.2 — Fiche d'inscription (35 min) · niveau semi-guidé

Écrire un programme qui :
1. demande le nom, le prénom et la date de naissance (format JJMMAAAA) ;
2. récupère la date du jour avec `ACCEPT ... FROM DATE YYYYMMDD` ;
3. affiche une fiche récapitulative avec les dates au format `JJ/MM/AAAA`.

Indices
- Décomposez la date saisie avec un groupe : `05 JJ PIC 99.` `05 MM PIC 99.` `05 AAAA PIC 9(4).`
- `FUNCTION TRIM(zone)` supprime les espaces de fin.

Défi : afficher aussi l'âge approximatif (différence d'années ; on verra le calcul exact en séance 2).

---

## TP1.3 — Laboratoire MOVE (35 min) · niveau découverte

Partie A — Prédire puis vérifier. Pour chaque MOVE, écrivez sur papier ce que vous
attendez, puis vérifiez en exécutant :

| Source | Destination | Résultat attendu ? |
| --- | --- | --- |
| `PIC 9(4) VALUE 1234` | `PIC 9(2)` | |
| `PIC 9(4) VALUE 1234` | `PIC 9(6)` | |
| `PIC 9(3)V99 VALUE 12.78` | `PIC 9(3)` | |
| `PIC 9(3)V99 VALUE 12.78` | `PIC 9(2)V9` | |
| `PIC X(8) VALUE "ABCDEFGH"` | `PIC X(4)` | |
| `PIC X(3) VALUE "ABC"` | `PIC X(6)` | |

Partie B — MOVE CORRESPONDING. Créez deux groupes `WS-SAISIE` (NOM, PRENOM, VILLE)
et `WS-AFFICHAGE` (PRENOM, NOM, PAYS) puis copiez les champs de même nom avec
`MOVE CORRESPONDING`. Quels champs sont copiés ? Lesquels ne le sont pas ?

Partie C — INITIALIZE. Remplissez un groupe avec des valeurs, puis réinitialisez-le
avec `INITIALIZE` : que contiennent les zones numériques et alphanumériques ?
