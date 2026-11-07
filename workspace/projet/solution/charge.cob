*> ===============================================================
*> MINI-PROJET - Programme 1 : CHARGE
*> Charge data/comptes.dat (séquentiel) dans out/comptes.idx (indexé).
*> Rejette les doublons (statut 22) et les types de compte invalides.
*> Lancer depuis le dossier workspace/projet :  cob solution/charge.cob
*> ===============================================================
IDENTIFICATION DIVISION.
PROGRAM-ID. CHARGE.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT F-ENTREE ASSIGN TO "data/comptes.dat"
        ORGANIZATION IS LINE SEQUENTIAL
        FILE STATUS IS WS-FS-ENT.
    SELECT F-COMPTES ASSIGN TO "out/comptes.idx"
        ORGANIZATION IS INDEXED
        ACCESS MODE IS DYNAMIC
        RECORD KEY IS CPT-NUM
        FILE STATUS IS WS-FS-CPT.

DATA DIVISION.
FILE SECTION.
FD F-ENTREE.
01 ENR-ENTREE       PIC X(31).
FD F-COMPTES.
COPY CPTREC.

WORKING-STORAGE SECTION.
01 WS-FS-ENT        PIC XX.
   88 ENT-OK               VALUE "00".
   88 ENT-FIN              VALUE "10".
01 WS-FS-CPT        PIC XX.
   88 CPT-OK               VALUE "00".
01 WS-NB-LUS        PIC 999 VALUE 0.
01 WS-NB-CHARGES    PIC 999 VALUE 0.
01 WS-NB-REJETS     PIC 999 VALUE 0.

PROCEDURE DIVISION.
0000-PRINCIPAL.
    PERFORM 1000-OUVRIR
    PERFORM 2000-LIRE
    PERFORM UNTIL ENT-FIN
        ADD 1 TO WS-NB-LUS
        PERFORM 3000-CHARGER-COMPTE
        PERFORM 2000-LIRE
    END-PERFORM
    PERFORM 9000-TERMINER
    STOP RUN.

1000-OUVRIR.
    OPEN INPUT F-ENTREE
    IF NOT ENT-OK
        DISPLAY "ERREUR ouverture data/comptes.dat, statut " WS-FS-ENT
        STOP RUN
    END-IF
    OPEN OUTPUT F-COMPTES
    IF NOT CPT-OK
        DISPLAY "ERREUR creation out/comptes.idx, statut " WS-FS-CPT
        STOP RUN
    END-IF.

2000-LIRE.
    READ F-ENTREE
        AT END CONTINUE
    END-READ.

3000-CHARGER-COMPTE.
    MOVE ENR-ENTREE TO CPT-REC
    IF CPT-NUM IS NUMERIC
       AND CPT-SOLDE IS NUMERIC
       AND CPT-TYPE-OK
        WRITE CPT-REC
            INVALID KEY
                ADD 1 TO WS-NB-REJETS
                DISPLAY "Rejet ligne " WS-NB-LUS " : compte " CPT-NUM
                        " en double (statut " WS-FS-CPT ")"
            NOT INVALID KEY
                ADD 1 TO WS-NB-CHARGES
        END-WRITE
    ELSE
        ADD 1 TO WS-NB-REJETS
        DISPLAY "Rejet ligne " WS-NB-LUS " : donnees invalides (type ou numero)"
    END-IF.

9000-TERMINER.
    CLOSE F-ENTREE F-COMPTES
    DISPLAY "-----------------------------"
    DISPLAY "Lignes lues     : " WS-NB-LUS
    DISPLAY "Comptes charges : " WS-NB-CHARGES
    DISPLAY "Rejetes         : " WS-NB-REJETS.
