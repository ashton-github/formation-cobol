*> ---------------------------------------------------------------
*> Exemple 4.4 : création d'un fichier INDEXÉ à partir d'un séquentiel
*> Le doublon (client 5 présent 2 fois) provoque le statut 22.
*> ---------------------------------------------------------------
IDENTIFICATION DIVISION.
PROGRAM-ID. IDXCREA.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT F-CLIENTS ASSIGN TO "seance4/data/clients.dat"
        ORGANIZATION IS LINE SEQUENTIAL
        FILE STATUS IS WS-FS-SEQ.
    SELECT F-CLI-IDX ASSIGN TO "seance4/out/clients.idx"
        ORGANIZATION IS INDEXED
        ACCESS MODE IS DYNAMIC
        RECORD KEY IS CI-ID
        FILE STATUS IS WS-FS-IDX.

DATA DIVISION.
FILE SECTION.
FD F-CLIENTS.
01 ENR-CLIENT       PIC X(53).
FD F-CLI-IDX.
01 ENR-CLIENT-IDX.
   05 CI-ID         PIC 9(5).
   05 CI-NOM        PIC X(15).
   05 CI-PRENOM     PIC X(12).
   05 CI-VILLE      PIC X(12).
   05 CI-SOLDE      PIC 9(7)V99.

WORKING-STORAGE SECTION.
01 WS-FS-SEQ        PIC XX.
   88 SEQ-OK               VALUE "00".
   88 SEQ-FIN              VALUE "10".
01 WS-FS-IDX        PIC XX.
   88 IDX-OK               VALUE "00".
01 WS-NB-LUS        PIC 999 VALUE 0.
01 WS-NB-OK         PIC 999 VALUE 0.
01 WS-NB-REJETS     PIC 999 VALUE 0.

PROCEDURE DIVISION.
0000-PRINCIPAL.
    OPEN INPUT F-CLIENTS
    OPEN OUTPUT F-CLI-IDX
    IF NOT SEQ-OK OR NOT IDX-OK
        DISPLAY "Erreur ouverture : " WS-FS-SEQ " / " WS-FS-IDX
        STOP RUN
    END-IF

    READ F-CLIENTS
        AT END CONTINUE
    END-READ
    PERFORM UNTIL SEQ-FIN
        ADD 1 TO WS-NB-LUS
        MOVE ENR-CLIENT TO ENR-CLIENT-IDX
        WRITE ENR-CLIENT-IDX
            INVALID KEY
                ADD 1 TO WS-NB-REJETS
                DISPLAY "Rejet (statut " WS-FS-IDX ") client " CI-ID
            NOT INVALID KEY
                ADD 1 TO WS-NB-OK
        END-WRITE
        READ F-CLIENTS
            AT END CONTINUE
        END-READ
    END-PERFORM

    CLOSE F-CLIENTS F-CLI-IDX
    DISPLAY "Lus    : " WS-NB-LUS
    DISPLAY "Charges: " WS-NB-OK
    DISPLAY "Rejets : " WS-NB-REJETS
    STOP RUN.
