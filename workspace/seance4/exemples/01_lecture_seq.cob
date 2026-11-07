*> ---------------------------------------------------------------
*> Exemple 4.1 : lecture d'un fichier SÉQUENTIEL
*> Lancer depuis le dossier workspace :  cob seance4/exemples/01_lecture_seq.cob
*> Schéma : OPEN -> READ (amorce) -> boucle (traiter, READ) -> CLOSE
*> ---------------------------------------------------------------
IDENTIFICATION DIVISION.
PROGRAM-ID. LECTSEQ.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT F-PRODUITS ASSIGN TO "seance4/data/produits.dat"
        ORGANIZATION IS LINE SEQUENTIAL
        FILE STATUS IS WS-FS.

DATA DIVISION.
FILE SECTION.
FD F-PRODUITS.
01 ENR-PRODUIT.
   05 PRD-CODE      PIC X(5).
   05 PRD-LIBELLE   PIC X(20).
   05 PRD-PRIX      PIC 9(4)V99.
   05 PRD-STOCK     PIC 9(4).

WORKING-STORAGE SECTION.
01 WS-FS            PIC XX.
   88 FS-OK                VALUE "00".
   88 FS-FIN               VALUE "10".
01 WS-NB            PIC 9(4)    VALUE 0.
01 WS-VALEUR-LIGNE  PIC 9(8)V99.
01 WS-VALEUR-TOTALE PIC 9(9)V99 VALUE 0.
01 WS-ED-PRIX       PIC ZZZ9.99.
01 WS-ED-VAL        PIC Z,ZZZ,ZZ9.99.

PROCEDURE DIVISION.
0000-PRINCIPAL.
    OPEN INPUT F-PRODUITS
    IF NOT FS-OK
        DISPLAY "Erreur d'ouverture, statut = " WS-FS
        STOP RUN
    END-IF

    DISPLAY "Code  Libelle              Prix  Stock"
    READ F-PRODUITS
        AT END CONTINUE
    END-READ
    PERFORM UNTIL FS-FIN
        PERFORM 1000-TRAITER-PRODUIT
        READ F-PRODUITS
            AT END CONTINUE
        END-READ
    END-PERFORM
    CLOSE F-PRODUITS

    MOVE WS-VALEUR-TOTALE TO WS-ED-VAL
    DISPLAY "Produits lus      : " WS-NB
    DISPLAY "Valeur du stock   : " WS-ED-VAL
    STOP RUN.

1000-TRAITER-PRODUIT.
    ADD 1 TO WS-NB
    MOVE PRD-PRIX TO WS-ED-PRIX
    DISPLAY PRD-CODE " " PRD-LIBELLE " " WS-ED-PRIX "  " PRD-STOCK
    COMPUTE WS-VALEUR-LIGNE = PRD-PRIX * PRD-STOCK
    ADD WS-VALEUR-LIGNE TO WS-VALEUR-TOTALE.
