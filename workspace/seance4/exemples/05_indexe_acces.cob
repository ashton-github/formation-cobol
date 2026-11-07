*> ---------------------------------------------------------------
*> Exemple 4.5 : accès à un fichier indexé (DYNAMIC)
*>   READ par clé, REWRITE, DELETE, START + READ NEXT
*> Prérequis : avoir lancé 04_indexe_creation.cob. Pour repartir de zéro,
*> relancez-le (il recrée le fichier).
*> ---------------------------------------------------------------
IDENTIFICATION DIVISION.
PROGRAM-ID. IDXACC.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT F-CLI-IDX ASSIGN TO "seance4/out/clients.idx"
        ORGANIZATION IS INDEXED
        ACCESS MODE IS DYNAMIC
        RECORD KEY IS CI-ID
        FILE STATUS IS WS-FS.

DATA DIVISION.
FILE SECTION.
FD F-CLI-IDX.
01 ENR-CLIENT-IDX.
   05 CI-ID         PIC 9(5).
   05 CI-NOM        PIC X(15).
   05 CI-PRENOM     PIC X(12).
   05 CI-VILLE      PIC X(12).
   05 CI-SOLDE      PIC 9(7)V99.

WORKING-STORAGE SECTION.
01 WS-FS            PIC XX.
   88 FS-OK                VALUE "00".
   88 FS-FIN               VALUE "10".
01 WS-ED-SOLDE      PIC Z,ZZZ,ZZ9.99.

PROCEDURE DIVISION.
0000-PRINCIPAL.
    OPEN I-O F-CLI-IDX
    IF NOT FS-OK
        DISPLAY "Ouverture impossible (statut " WS-FS ") - lancez d'abord 04_indexe_creation"
        STOP RUN
    END-IF

    PERFORM 1000-LECTURE-DIRECTE
    PERFORM 2000-MODIFICATION
    PERFORM 3000-SUPPRESSION
    PERFORM 4000-LISTE-A-PARTIR-DE
    CLOSE F-CLI-IDX
    STOP RUN.

1000-LECTURE-DIRECTE.
    DISPLAY "--- READ par cle : client 3 ---"
    MOVE 3 TO CI-ID
    READ F-CLI-IDX
        INVALID KEY
            DISPLAY "Client 3 introuvable (statut " WS-FS ")"
        NOT INVALID KEY
            MOVE CI-SOLDE TO WS-ED-SOLDE
            DISPLAY CI-NOM " " CI-PRENOM " solde " WS-ED-SOLDE
    END-READ.

2000-MODIFICATION.
    DISPLAY "--- REWRITE : +100.00 sur le client 3 ---"
    MOVE 3 TO CI-ID
    READ F-CLI-IDX
        INVALID KEY
            DISPLAY "Client 3 introuvable"
        NOT INVALID KEY
            ADD 100.00 TO CI-SOLDE
            REWRITE ENR-CLIENT-IDX
                INVALID KEY DISPLAY "Erreur REWRITE " WS-FS
            END-REWRITE
            MOVE CI-SOLDE TO WS-ED-SOLDE
            DISPLAY "Nouveau solde : " WS-ED-SOLDE
    END-READ.

3000-SUPPRESSION.
    DISPLAY "--- DELETE : client 7 ---"
    MOVE 7 TO CI-ID
    DELETE F-CLI-IDX RECORD
        INVALID KEY DISPLAY "Client 7 introuvable"
        NOT INVALID KEY DISPLAY "Client 7 supprime"
    END-DELETE.

4000-LISTE-A-PARTIR-DE.
    DISPLAY "--- START + READ NEXT : clients de cle >= 5 ---"
    MOVE 5 TO CI-ID
    START F-CLI-IDX KEY IS NOT LESS THAN CI-ID
        INVALID KEY
            DISPLAY "Aucun client de cle >= 5"
        NOT INVALID KEY
            PERFORM UNTIL FS-FIN
                READ F-CLI-IDX NEXT RECORD
                    AT END CONTINUE
                    NOT AT END
                        DISPLAY CI-ID " " CI-NOM " " CI-VILLE
                END-READ
            END-PERFORM
    END-START.
