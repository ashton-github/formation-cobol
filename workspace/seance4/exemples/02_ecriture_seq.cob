*> ---------------------------------------------------------------
*> Exemple 4.2 : écriture d'un fichier séquentiel
*> Copie vers seance4/out/stock_bas.dat les produits dont le stock < 10.
*> OPEN OUTPUT crée/écrase le fichier ; OPEN EXTEND ajoute à la fin.
*> ---------------------------------------------------------------
IDENTIFICATION DIVISION.
PROGRAM-ID. ECRSEQ.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT F-PRODUITS ASSIGN TO "seance4/data/produits.dat"
        ORGANIZATION IS LINE SEQUENTIAL
        FILE STATUS IS WS-FS-IN.
    SELECT F-ALERTE ASSIGN TO "seance4/out/stock_bas.dat"
        ORGANIZATION IS LINE SEQUENTIAL
        FILE STATUS IS WS-FS-OUT.

DATA DIVISION.
FILE SECTION.
FD F-PRODUITS.
01 ENR-PRODUIT.
   05 PRD-CODE      PIC X(5).
   05 PRD-LIBELLE   PIC X(20).
   05 PRD-PRIX      PIC 9(4)V99.
   05 PRD-STOCK     PIC 9(4).
FD F-ALERTE.
01 ENR-ALERTE       PIC X(35).

WORKING-STORAGE SECTION.
01 WS-FS-IN         PIC XX.
   88 IN-OK                VALUE "00".
   88 IN-FIN               VALUE "10".
01 WS-FS-OUT        PIC XX.
   88 OUT-OK               VALUE "00".
01 WS-NB-LUS        PIC 9(4) VALUE 0.
01 WS-NB-ECRITS     PIC 9(4) VALUE 0.

PROCEDURE DIVISION.
0000-PRINCIPAL.
    OPEN INPUT F-PRODUITS
    OPEN OUTPUT F-ALERTE
    IF NOT IN-OK OR NOT OUT-OK
        DISPLAY "Erreur d'ouverture : " WS-FS-IN " / " WS-FS-OUT
        STOP RUN
    END-IF

    READ F-PRODUITS
        AT END CONTINUE
    END-READ
    PERFORM UNTIL IN-FIN
        ADD 1 TO WS-NB-LUS
        IF PRD-STOCK < 10
            WRITE ENR-ALERTE FROM ENR-PRODUIT
            ADD 1 TO WS-NB-ECRITS
        END-IF
        READ F-PRODUITS
            AT END CONTINUE
        END-READ
    END-PERFORM

    CLOSE F-PRODUITS F-ALERTE
    DISPLAY "Lus     : " WS-NB-LUS
    DISPLAY "Ecrits  : " WS-NB-ECRITS " (fichier seance4/out/stock_bas.dat)"
    STOP RUN.
