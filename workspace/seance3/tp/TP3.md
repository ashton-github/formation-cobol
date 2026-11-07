# Séance 3 — Travaux pratiques

---

## TP3.1 — Tableau de notes (40 min) · niveau guidé

1. Déclarer une table de 8 notes (`PIC 99V99`, `OCCURS 8 TIMES`).
2. Saisir les 8 notes (lecture texte + `FUNCTION NUMVAL`).
3. Calculer et afficher : somme, moyenne, note minimale, note maximale.
4. Compter combien de notes sont au-dessus de la moyenne.
5. Défi : trier les notes par ordre décroissant (tri à bulles) et les réafficher.

## TP3.2 — Atelier chaînes (40 min) · semi-guidé

À partir de la ligne `martin;SOPHIE;lyon` (zone `PIC X(40)`) :
1. Découper avec `UNSTRING ... DELIMITED BY ";"`.
2. Mettre en forme : prénom avec initiale majuscule et reste en minuscules, nom en majuscules, ville avec initiale majuscule.
3. Assembler avec `STRING` : `Sophie MARTIN, Lyon`.
4. Palindrome : saisir un mot et dire s'il est un palindrome (`radar`, `Kayak`...), sans tenir compte de la casse (`FUNCTION REVERSE`, `FUNCTION UPPER-CASE`).
5. Compter les voyelles d'une phrase saisie avec `INSPECT ... TALLYING`.

## TP3.3 — Sous-programme et copybook (40 min) · niveau libre

Écrire un sous-programme `VALDATE` qui valide une date `JJMMAAAA` :
- paramètres : la date (groupe JJ, MM, AAAA) et un code retour (0 = valide, 1 = invalide) ;
- règles : mois de 1 à 12, jour compris entre 1 et le nombre de jours du mois, février = 29 jours les années bissextiles (divisible par 4 et non par 100, ou divisible par 400).

Puis un programme principal qui teste une table de dates :
`29022024`, `29022023`, `31042025`, `31122025`, `15132025`, `01012000`
et affiche `OK` ou `INVALIDE` pour chacune.

Résultats attendus : OK, INVALIDE, INVALIDE, OK, INVALIDE, OK.

Compilation : `cob seance3/tp/tp3_3.cob seance3/tp/valdate.cob`
