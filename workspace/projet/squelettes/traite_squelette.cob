*> SQUELETTE - Programme 2 : TRAITE   (à compléter : zones TODO)
*> Le DEPOT est fourni comme exemple ; à vous : RETRAIT puis VIREMENT.
*> Lancer depuis le dossier workspace/projet :  cob squelettes/traite_squelette.cob
IDENTIFICATION DIVISION.
PROGRAM-ID. TRAITE.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT F-TRN ASSIGN TO "data/transactions.dat"
        ORGANIZATION IS LINE SEQUENTIAL
        FILE STATUS IS WS-FS-TRN.
    SELECT F-COMPTES ASSIGN TO "out/comptes.idx"
        ORGANIZATION IS INDEXED
        ACCESS MODE IS DYNAMIC
        RECORD KEY IS CPT-NUM
        FILE STATUS IS WS-FS-CPT.
    SELECT F-REJETS ASSIGN TO "out/rejets.txt"
        ORGANIZATION IS LINE SEQUENTIAL
        FILE STATUS IS WS-FS-REJ.

DATA DIVISION.
FILE SECTION.
FD F-TRN.
COPY TRNREC.
FD F-COMPTES.
COPY CPTREC.
FD F-REJETS.
01 ENR-REJET.
   05 REJ-TRN       PIC X(20).
   05 REJ-SEP       PIC X.
   05 REJ-MOTIF     PIC X(25).

WORKING-STORAGE SECTION.
01 WS-FS-TRN        PIC XX.
   88 TRN-OK               VALUE "00".
   88 TRN-FIN              VALUE "10".
01 WS-FS-CPT        PIC XX.
   88 CPT-OK               VALUE "00".
01 WS-FS-REJ        PIC XX.
   88 REJ-OK               VALUE "00".
01 WS-MOTIF         PIC X(25).
01 WS-REJET         PIC X VALUE "N".
   88 REJET-OUI            VALUE "O".
   88 REJET-NON            VALUE "N".
*> TODO : compteurs (lues, depots, retraits, virements, rejets) et totaux

PROCEDURE DIVISION.
0000-PRINCIPAL.
    *> TODO : ouverture (F-TRN INPUT, F-COMPTES I-O, F-REJETS OUTPUT)
    *> TODO : boucle de lecture des transactions -> PERFORM 3000-TRAITER
    *> TODO : fermeture + résumé
    STOP RUN.

*> Ordre des contrôles (motifs EXACTS exigés, voir l'énoncé) :
*>  1. TYPE INVALIDE   2. MONTANT NUL   3. COMPTE INCONNU   4. règles du type
3000-TRAITER.
    SET REJET-NON TO TRUE
    *> TODO : appliquer les contrôles 1 à 3 puis EVALUATE TRUE sur le type
    IF REJET-OUI
        PERFORM 8000-ECRIRE-REJET
    END-IF.

3200-DEPOT.
    ADD TRN-MONTANT TO CPT-SOLDE
        ON SIZE ERROR
            MOVE "DEPASSEMENT CAPACITE" TO WS-MOTIF
            SET REJET-OUI TO TRUE
        NOT ON SIZE ERROR
            REWRITE CPT-REC
            *> TODO : compter le dépôt et cumuler le montant
    END-ADD.

3300-RETRAIT.
    *> TODO : plafond 1000, solde suffisant, SUBTRACT + REWRITE
    CONTINUE.

3400-VIREMENT.
    *> TODO : source != destination, destination existante, solde suffisant,
    *>        crédit destinataire + débit source (attention : un seul
    *>        enregistrement CPT-REC en mémoire !)
    CONTINUE.

8000-ECRIRE-REJET.
    *> TODO : MOVE SPACES TO ENR-REJET, TRN-REC -> REJ-TRN, motif, WRITE
    CONTINUE.
