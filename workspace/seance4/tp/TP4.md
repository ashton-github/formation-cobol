# Séance 4 — Travaux pratiques

Toujours depuis le dossier `workspace`. Les données sont dans `seance4/data/`, vos sorties dans `seance4/out/`.

| Fichier | Enregistrement (largeur fixe) |
| --- | --- |
| `produits.dat` (35 car.) | code `X(5)` · libellé `X(20)` · prix `9(4)V99` · stock `9(4)` |
| `clients.dat` (53 car.) | id `9(5)` · nom `X(15)` · prénom `X(12)` · ville `X(12)` · solde `9(7)V99` |
| `ventes.dat` (27 car.) | région `X(10)` · vendeur `X(10)` · montant `9(5)V99` |

---

## TP4.1 — Rapport de stock (35 min) · niveau guidé

Lire `produits.dat` et produire :
1. un affichage tabulaire avec en-tête : code, libellé, prix, stock, valeur (prix × stock) — montants édités ;
2. la mention `A COMMANDER` en bout de ligne quand le stock est inférieur à 10 ;
3. le même rapport écrit dans `seance4/out/rapport_stock.txt` ;
4. à la fin : nombre de produits, valeur totale du stock, nombre de produits à commander.

Valeurs attendues : 10 produits, valeur totale 1 741,10, 4 produits à commander.

## TP4.2 — Gestion de clients en fichier indexé (50 min) · semi-guidé

Programme à menu sur `seance4/out/clients.idx` (créé par l'exemple 4.4) :

```
1. Consulter un client      4. Supprimer un client
2. Ajouter un client        5. Lister tous les clients
3. Créditer / débiter       0. Quitter
```

Règles : refuser l'ajout d'une clé existante ; refuser un débit supérieur au solde ; tester le FILE STATUS après chaque ouverture ; si le fichier n'existe pas (statut 35), le créer.

## TP4.3 — Ventes par région : tri, rupture, pourcentages (45 min) · niveau libre

1. Trier `ventes.dat` par région puis vendeur (`SORT`).
2. Éditer un sous-total par région (rupture de contrôle) et le total général.
3. Terminer par un tableau récapitulatif : région, total, part du total en pourcentage.

Totaux attendus : NORD 5 290,00 · SUD 3 235,75 · EST 3 470,75 · OUEST 2 470,40 · général 14 466,90.

Défi : afficher aussi le meilleur vendeur de chaque région (rupture à deux niveaux : région puis vendeur).
