*> ---------------------------------------------------------------
*> Exemple 4.3 : FILE STATUS - ne jamais ignorer un code retour !
*> Ouvre volontairement un fichier qui n'existe pas (statut 35).
*> ---------------------------------------------------------------
IDENTIFICATION DIVISION.
PROGRAM-ID. FSTATUS.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT F-INCONNU ASSIGN TO "seance4/data/inexistant.dat"
        ORGANIZATION IS LINE SEQUENTIAL
        FILE STATUS IS WS-FS.

DATA DIVISION.
FILE SECTION.
FD F-INCONNU.
01 ENR-INCONNU      PIC X(80).

WORKING-STORAGE SECTION.
01 WS-FS            PIC XX.
01 WS-MESSAGE       PIC X(40).

PROCEDURE DIVISION.
    OPEN INPUT F-INCONNU
    PERFORM 9000-DECODER-STATUT
    DISPLAY "Statut " WS-FS " : " WS-MESSAGE
    STOP RUN.

9000-DECODER-STATUT.
    EVALUATE WS-FS
        WHEN "00"  MOVE "Operation reussie"              TO WS-MESSAGE
        WHEN "10"  MOVE "Fin de fichier"                 TO WS-MESSAGE
        WHEN "21"  MOVE "Erreur de sequence de cle"      TO WS-MESSAGE
        WHEN "22"  MOVE "Cle en double"                  TO WS-MESSAGE
        WHEN "23"  MOVE "Enregistrement non trouve"      TO WS-MESSAGE
        WHEN "35"  MOVE "Fichier inexistant (OPEN INPUT)" TO WS-MESSAGE
        WHEN "37"  MOVE "Permission refusee"             TO WS-MESSAGE
        WHEN "41"  MOVE "Fichier deja ouvert"            TO WS-MESSAGE
        WHEN "42"  MOVE "Fichier non ouvert"             TO WS-MESSAGE
        WHEN OTHER MOVE "Autre erreur (voir le manuel)"  TO WS-MESSAGE
    END-EVALUATE.
