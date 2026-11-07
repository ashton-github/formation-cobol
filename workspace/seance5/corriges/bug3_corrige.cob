*> BUG3 corrigé :
*>  1) boucle jusqu'à 4 alors que la table n'a que 3 éléments (indice hors limites)
*>  2) STRING n'efface pas la zone cible : les caractères restants de l'appel
*>     précédent subsistent -> MOVE SPACES TO WS-LIGNE avant chaque STRING
IDENTIFICATION DIVISION.
PROGRAM-ID. BUG3OK.

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

    PERFORM VARYING WS-I FROM 1 BY 1 UNTIL WS-I > 3
        MOVE SPACES TO WS-LIGNE
        STRING "Bonjour "                   DELIMITED BY SIZE
               FUNCTION TRIM(WS-NOM(WS-I))  DELIMITED BY SIZE
               "!"                          DELIMITED BY SIZE
            INTO WS-LIGNE
        END-STRING
        DISPLAY FUNCTION TRIM(WS-LIGNE)
    END-PERFORM
    STOP RUN.
