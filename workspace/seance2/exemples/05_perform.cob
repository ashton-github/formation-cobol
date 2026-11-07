*> ---------------------------------------------------------------
*> Exemple 2.5 : les formes de PERFORM
*> ---------------------------------------------------------------
IDENTIFICATION DIVISION.
PROGRAM-ID. PERF01.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 WS-I       PIC 99.
01 WS-SOMME   PIC 9(5)  VALUE 0.

PROCEDURE DIVISION.
MAIN-PARA.
    DISPLAY "--- PERFORM n TIMES ---"
    PERFORM 3 TIMES
        DISPLAY "Bonjour"
    END-PERFORM

    DISPLAY "--- PERFORM VARYING (somme de 1 a 5) ---"
    PERFORM VARYING WS-I FROM 1 BY 1 UNTIL WS-I > 5
        DISPLAY "i = " WS-I
        ADD WS-I TO WS-SOMME
    END-PERFORM
    DISPLAY "Somme = " WS-SOMME

    DISPLAY "--- PERFORM UNTIL (test AVANT) ---"
    MOVE 1 TO WS-I
    PERFORM UNTIL WS-I > 3
        DISPLAY "tour " WS-I
        ADD 1 TO WS-I
    END-PERFORM

    DISPLAY "--- TEST AFTER : execute au moins une fois ---"
    MOVE 10 TO WS-I
    PERFORM WITH TEST AFTER UNTIL WS-I > 5
        DISPLAY "execute avec i = " WS-I
        ADD 1 TO WS-I
    END-PERFORM

    DISPLAY "--- PERFORM d'un paragraphe ---"
    PERFORM AFFICHER-TITRE
    PERFORM AFFICHER-TITRE 2 TIMES
    STOP RUN.

AFFICHER-TITRE.
    DISPLAY "=== Titre ===".
