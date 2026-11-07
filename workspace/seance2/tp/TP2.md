# Séance 2 — Travaux pratiques

Créez vos programmes dans `seance2/tp/` et lancez-les avec `cob seance2/tp/tp2_1.cob`.

Astuce saisie numérique : lisez dans une zone texte puis convertissez.
```cobol
01 WS-SAISIE PIC X(15).
01 WS-N1     PIC S9(5)V99.
...
ACCEPT WS-SAISIE
COMPUTE WS-N1 = FUNCTION NUMVAL(WS-SAISIE)
```
`NUMVAL` accepte « 12.5 », « -3 », « 100 »...

---

## TP2.1 — Calculatrice à opérateurs (40 min) · niveau guidé

Programme qui boucle jusqu'à ce que l'utilisateur réponde `N` :
1. demande deux nombres puis un opérateur (`+ - * /`) ;
2. calcule avec `ADD / SUBTRACT / MULTIPLY / DIVIDE ... GIVING` choisi par `EVALUATE` ;
3. affiche le résultat avec une zone éditée (`PIC -(9)9.99`) ;
4. affiche « Erreur » pour une division par zéro (utiliser `ON SIZE ERROR`) ou un opérateur inconnu.

Bonus : mémoriser le dernier résultat et proposer de le réutiliser comme premier nombre.

---

## TP2.2 — Boucles : tables, somme, FizzBuzz, factorielle (30 min) · semi-guidé

1. Afficher la table de multiplication d'un nombre saisi (de 1 à 10).
2. Calculer la somme des entiers de 1 à N (N saisi).
3. FizzBuzz de 1 à 30 : `Fizz` si multiple de 3, `Buzz` si multiple de 5, `FizzBuzz` si multiple des deux, sinon le nombre. (Indice : `FUNCTION MOD(i, 3)`.)
4. Factorielle de N (zone `PIC 9(10)`) : à partir de quel N obtient-on un dépassement ? Utiliser `ON SIZE ERROR`.

---

## TP2.3 — Facture avec remise et TVA (40 min) · niveau libre

Écrire un programme de facturation :
1. demander le nombre d'articles, puis pour chaque article la quantité et le prix unitaire ;
2. cumuler le total HT ;
3. appliquer une remise selon le total HT :

| Total HT | Remise |
| --- | --- |
| moins de 100 | 0 % |
| de 100 à 499,99 | 5 % |
| de 500 à 999,99 | 10 % |
| 1000 et plus | 15 % |

4. calculer la TVA à 20 % sur le net après remise (arrondie), puis le TTC ;
5. afficher une facture lisible avec des zones éditées (`PIC Z,ZZZ,ZZ9.99`).

Défi : afficher aussi la remise en pourcentage et vérifier le cas limite 100,00 et 999,99.
