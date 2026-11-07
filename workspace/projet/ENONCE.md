# Mini-projet — « BANQUE » : traitement batch de comptes bancaires

Durée : 2 h (séance 5) · Travail individuel ou en binôme · Environnement : GnuCOBOL (installation locale)

## Contexte

Une petite banque reçoit chaque jour un fichier de **transactions** (dépôts, retraits,
virements) à appliquer sur son fichier de **comptes**. Vous écrivez la chaîne batch
complète, en trois programmes COBOL :

```
data/comptes.dat ──► [1] CHARGE ──► out/comptes.idx ──► [2] TRAITE ──► out/comptes.idx (mis à jour)
                                          ▲                  │               out/rejets.txt
data/transactions.dat ────────────────────┘                  ▼
                                                      [3] EDITION ──► out/releve.txt
```

Tout se lance depuis le dossier `workspace/projet`.

## Formats des fichiers (largeur fixe, un enregistrement par ligne)

| Fichier | Zone | Format | Position |
| --- | --- | --- | --- |
| `comptes.dat` (31 car.) | Numéro de compte | `9(6)` | 1-6 |
| | Titulaire | `X(15)` | 7-21 |
| | Type : `C` courant, `E` épargne | `X` | 22 |
| | Solde (2 décimales implicites) | `9(7)V99` | 23-31 |
| `transactions.dat` (20 car.) | Compte concerné | `9(6)` | 1-6 |
| | Type : `D` dépôt, `R` retrait, `V` virement | `X` | 7 |
| | Montant | `9(5)V99` | 8-14 |
| | Compte destinataire (virement seulement, sinon 000000) | `9(6)` | 15-20 |

Les structures sont déjà fournies dans `copy/CPTREC.cpy` et `copy/TRNREC.cpy` (à utiliser avec `COPY`).

## Programme 1 — CHARGE

Charger `comptes.dat` dans le fichier indexé `out/comptes.idx` (clé : numéro de compte).
- Rejeter (avec message à l'écran) un numéro déjà présent (statut 22) et un type différent de `C`/`E`.
- Afficher : lignes lues, comptes chargés, rejetés.

Attendu : 15 lues, 13 chargées, 2 rejetées.

## Programme 2 — TRAITE

Appliquer chaque transaction **dans l'ordre du fichier**. Les contrôles se font dans cet
ordre ; la première règle violée rejette la transaction, qui est écrite dans `out/rejets.txt`
(transaction de 20 caractères, un espace, puis le **motif exact** ci-dessous).

| Ordre | Contrôle | Motif exact |
| --- | --- | --- |
| 1 | Type différent de D, R, V | `TYPE INVALIDE` |
| 2 | Montant égal à zéro | `MONTANT NUL` |
| 3 | Compte inexistant | `COMPTE INCONNU` |
| 4 | **Dépôt** : le nouveau solde dépasse 9 999 999,99 | `DEPASSEMENT CAPACITE` |
| 4 | **Retrait** : montant supérieur à 1 000,00 (plafond) | `PLAFOND DEPASSE` |
| 5 | **Retrait** : solde inférieur au montant | `SOLDE INSUFFISANT` |
| 4 | **Virement** : destinataire = source | `VIREMENT VERS SOI-MEME` |
| 5 | **Virement** : destinataire inexistant | `COMPTE DEST INCONNU` |
| 6 | **Virement** : solde source inférieur au montant | `SOLDE INSUFFISANT` |
| 7 | **Virement** : le solde du destinataire dépasserait le maximum | `DEPASSEMENT CAPACITE` |

À la fin, afficher : transactions lues, acceptées par type, rejetées, totaux des montants
déposés, retirés et virés.

Attendu : 22 lues, 11 acceptées (4 dépôts, 5 retraits, 2 virements), 11 rejetées ; dépôts 504,75 ·
retraits 4 039,99 · virements 700,00. Le fichier `out/rejets.txt` doit être identique à `attendu/rejets.txt`.

## Programme 3 — EDITION

Produire le relevé des comptes à l'écran **et** dans `out/releve.txt` :
- trié par type de compte (`C` puis `E`), puis par solde décroissant (`SORT`) ;
- rupture de contrôle sur le type : un sous-total (nombre de comptes + montant) par type ;
- total général en fin de relevé ;
- montants édités (`Z,ZZZ,ZZ9.99`) ; les totaux sur 10 chiffres.

Attendu : type C : 8 comptes, 3 470,30 · type E : 5 comptes, 10 041 775,01 · total 13 comptes, 10 045 245,31.

## Livrables

1. Les trois programmes `.cob` commentés (nom, rôle, hypothèses).
2. Les fichiers générés `out/rejets.txt` et `out/releve.txt`.
3. Un court compte rendu (10 lignes) : difficultés rencontrées, un bug trouvé et sa cause.

Vérification : `./verifier.sh` compare votre `rejets.txt` au fichier attendu. Le détail des soldes
finaux est dans `attendu/resume.txt`.

## Barème (20 points)

| Critère | Points |
| --- | --- |
| CHARGE : fichier indexé correct, doublons et types invalides rejetés | 3 |
| TRAITE : dépôts et retraits corrects, ON SIZE ERROR utilisé | 4 |
| TRAITE : virements corrects (deux comptes mis à jour) | 3 |
| Fichier des rejets conforme (motifs et ordre des contrôles) | 3 |
| EDITION : tri, rupture de contrôle, totaux justes | 4 |
| Qualité : paragraphes numérotés, FILE STATUS testé, copybooks, commentaires | 3 |

Bonus (+2) : extension libre (ex. intérêts mensuels sur les comptes épargne, table des plafonds par type, historique des mouvements).

## Aide

Les squelettes sont dans `squelettes/`. La solution complète est dans `solution/` (réservée au formateur) ;
`./run_all.sh` l'exécute de bout en bout.
