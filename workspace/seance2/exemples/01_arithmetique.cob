*> ---------------------------------------------------------------
*> Exemple 2.1 : ADD / SUBTRACT / MULTIPLY / DIVIDE / COMPUTE
*> Les résultats sont affichés via une zone ÉDITÉE (point décimal visible).
*> ---------------------------------------------------------------
IDENTIFICATION DIVISION.
PROGRAM-ID. ARITH01.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 WS-A         PIC 9(4)V99  VALUE 100.50.
01 WS-B         PIC 9(4)V99  VALUE 25.25.
01 WS-RES       PIC 9(6)V99.
01 WS-RES2      PIC 9(6)V99.
01 WS-QUOTIENT  PIC 9(4).
01 WS-RESTE     PIC 9(4).
01 WS-PETIT     PIC 9(2)     VALUE 99.
01 WS-AFF       PIC ZZZ,ZZ9.99.
01 WS-AFF2      PIC ZZZ,ZZ9.99.

PROCEDURE DIVISION.
    ADD WS-A WS-B GIVING WS-RES
    MOVE WS-RES TO WS-AFF
    DISPLAY "ADD       100.50 + 25.25     = " WS-AFF

    SUBTRACT WS-B FROM WS-A GIVING WS-RES
    MOVE WS-RES TO WS-AFF
    DISPLAY "SUBTRACT  100.50 - 25.25     = " WS-AFF

    MULTIPLY WS-A BY 2 GIVING WS-RES
    MOVE WS-RES TO WS-AFF
    DISPLAY "MULTIPLY  100.50 x 2         = " WS-AFF

    DIVIDE WS-A BY WS-B GIVING WS-RES
    MOVE WS-RES TO WS-AFF
    DISPLAY "DIVIDE    100.50 / 25.25     = " WS-AFF

    DIVIDE 17 BY 5 GIVING WS-QUOTIENT REMAINDER WS-RESTE
    DISPLAY "DIVIDE    17 / 5             = " WS-QUOTIENT " reste " WS-RESTE

    COMPUTE WS-RES = (WS-A + WS-B) * 2 / 3
    MOVE WS-RES TO WS-AFF
    DISPLAY "COMPUTE   (A + B) * 2 / 3    = " WS-AFF

    *> Tronqué (par défaut) contre arrondi (ROUNDED)
    COMPUTE WS-RES  = WS-A / 7
    COMPUTE WS-RES2 ROUNDED = WS-A / 7
    MOVE WS-RES  TO WS-AFF
    MOVE WS-RES2 TO WS-AFF2
    DISPLAY "A / 7 tronque                = " WS-AFF
    DISPLAY "A / 7 ROUNDED                = " WS-AFF2

    *> Dépassement de capacité : ON SIZE ERROR
    COMPUTE WS-PETIT = 50 * 3
        ON SIZE ERROR
            DISPLAY "ERREUR : 50 x 3 ne tient pas dans PIC 9(2)"
        NOT ON SIZE ERROR
            DISPLAY "Resultat : " WS-PETIT
    END-COMPUTE
    DISPLAY "WS-PETIT inchange (SIZE ERROR) : " WS-PETIT
    STOP RUN.
