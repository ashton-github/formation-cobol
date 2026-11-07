*> BUG3 : message d'accueil pour 3 personnes.
*> Attendu : Bonjour Alexandre! / Bonjour Eve! / Bonjour Bob!
*> A tester avec :  cob seance5/tp/bug3.cob   puis   cob -d seance5/tp/bug3.cob
IDENTIFICATION DIVISION.
PROGRAM-ID. BUG3.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 WS-NOMS.
   05 WS-NOM     PIC X(10) OCCURS 3 TIMES.
01 WS-LIGNE      PIC X(30) VALUE SPACES.
01 WS-I          PIC 9.

PROCEDURE DIVISION.
    MOVE "Alexandre" TO WS-NOM(1)
    MOVE "Eve"       TO WS-NOM(2)
    MOVE "Bob"       TO WS-NOM(3)

    PERFORM VARYING WS-I FROM 1 BY 1 UNTIL WS-I > 4
        STRING "Bonjour "                   DELIMITED BY SIZE
               FUNCTION TRIM(WS-NOM(WS-I))  DELIMITED BY SIZE
               "!"                          DELIMITED BY SIZE
            INTO WS-LIGNE
        END-STRING
        DISPLAY WS-LIGNE
    END-PERFORM
    STOP RUN.
