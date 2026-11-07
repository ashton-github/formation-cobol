*> SQUELETTE - Programme 3 : EDITION   (à compléter : zones TODO)
*> Relevé trié par type puis solde décroissant, avec sous-totaux (rupture).
*> Lancer depuis le dossier workspace/projet :  cob squelettes/edition_squelette.cob
IDENTIFICATION DIVISION.
PROGRAM-ID. EDITION.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT F-COMPTES ASSIGN TO "out/comptes.idx"
        ORGANIZATION IS INDEXED
        ACCESS MODE IS DYNAMIC
        RECORD KEY IS CPT-NUM
        FILE STATUS IS WS-FS-CPT.
    SELECT F-TRIE ASSIGN TO "out/comptes_tri.dat"
        ORGANIZATION IS LINE SEQUENTIAL
        FILE STATUS IS WS-FS-TRIE.
    SELECT F-TRI ASSIGN TO "sortwork".
    SELECT F-RELEVE ASSIGN TO "out/releve.txt"
        ORGANIZATION IS LINE SEQUENTIAL.

DATA DIVISION.
FILE SECTION.
FD F-COMPTES.
COPY CPTREC.
FD F-TRIE.
01 ENR-TRIE.
   05 TR-NUM        PIC 9(6).
   05 TR-NOM        PIC X(15).
   05 TR-TYPE       PIC X.
   05 TR-SOLDE      PIC 9(7)V99.
SD F-TRI.
01 ENR-TRI.
   05 S-NUM         PIC 9(6).
   05 S-NOM         PIC X(15).
   05 S-TYPE        PIC X.
   05 S-SOLDE       PIC 9(7)V99.
FD F-RELEVE.
01 ENR-RELEVE       PIC X(80).

WORKING-STORAGE SECTION.
01 WS-FS-CPT        PIC XX.
01 WS-FS-TRIE       PIC XX.
   88 TRIE-OK              VALUE "00".
   88 TRIE-FIN             VALUE "10".
*> TODO : zones de rupture (type courant, cumuls) et lignes d'édition
*>        (utiliser des zones éditées PIC Z,ZZZ,ZZ9.99 ; totaux sur 10 chiffres)

PROCEDURE DIVISION.
0000-PRINCIPAL.
    *> TODO 1 : SORT F-TRI ON ASCENDING KEY S-TYPE ON DESCENDING KEY S-SOLDE
    *>               USING F-COMPTES GIVING F-TRIE
    *> TODO 2 : ouvrir F-TRIE (INPUT) et F-RELEVE (OUTPUT), éditer l'en-tête
    *> TODO 3 : rupture de contrôle sur TR-TYPE : détail, sous-total, total général
    *> TODO 4 : écrire chaque ligne à l'écran ET dans out/releve.txt
    STOP RUN.
