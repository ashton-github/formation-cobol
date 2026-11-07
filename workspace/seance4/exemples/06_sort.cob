*> ---------------------------------------------------------------
*> Exemple 4.6 : SORT avec USING / GIVING
*> Trie les ventes par région (croissant) puis montant (décroissant).
*> Résultat : seance4/out/ventes_tri.dat
*> ---------------------------------------------------------------
IDENTIFICATION DIVISION.
PROGRAM-ID. TRIVENTE.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT F-VENTES ASSIGN TO "seance4/data/ventes.dat"
        ORGANIZATION IS LINE SEQUENTIAL.
    SELECT F-TRIE   ASSIGN TO "seance4/out/ventes_tri.dat"
        ORGANIZATION IS LINE SEQUENTIAL.
    SELECT F-TRI    ASSIGN TO "sortwork".

DATA DIVISION.
FILE SECTION.
FD F-VENTES.
01 ENR-VENTE        PIC X(27).
FD F-TRIE.
01 ENR-TRIE         PIC X(27).
SD F-TRI.
01 ENR-TRI.
   05 T-REGION      PIC X(10).
   05 T-VENDEUR     PIC X(10).
   05 T-MONTANT     PIC 9(5)V99.

PROCEDURE DIVISION.
    SORT F-TRI
        ON ASCENDING KEY  T-REGION
        ON DESCENDING KEY T-MONTANT
        USING F-VENTES
        GIVING F-TRIE
    DISPLAY "Tri termine : seance4/out/ventes_tri.dat"
    DISPLAY "Contenu : cat seance4/out/ventes_tri.dat"
    STOP RUN.
