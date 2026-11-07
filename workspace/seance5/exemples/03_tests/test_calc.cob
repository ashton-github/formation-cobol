*> ---------------------------------------------------------------
*> Exemple 5.3 : mini-harnais de tests unitaires en COBOL
*> Lancer :
*>   cob seance5/exemples/03_tests/test_calc.cob seance5/exemples/03_tests/calc.cob
*> Le code retour du programme vaut 1 si au moins un test échoue
*> (utile pour une intégration continue).
*> ---------------------------------------------------------------
IDENTIFICATION DIVISION.
PROGRAM-ID. TESTCALC.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 WS-NB-TESTS     PIC 99 VALUE 0.
01 WS-NB-ECHECS    PIC 99 VALUE 0.
01 WS-NOM-TEST     PIC X(28).
01 WS-A            PIC S9(5)V99.
01 WS-B            PIC S9(5)V99.
01 WS-OP           PIC X.
01 WS-RES          PIC S9(7)V99.
01 WS-CODE         PIC 9.
01 WS-ATTENDU      PIC S9(7)V99.
01 WS-CODE-ATTENDU PIC 9.

PROCEDURE DIVISION.
0000-PRINCIPAL.
    MOVE "Addition 2 + 3" TO WS-NOM-TEST
    MOVE 2 TO WS-A   MOVE 3 TO WS-B   MOVE "+" TO WS-OP
    MOVE 5 TO WS-ATTENDU   MOVE 0 TO WS-CODE-ATTENDU
    PERFORM 9000-EXECUTER-TEST

    MOVE "Soustraction 2 - 5" TO WS-NOM-TEST
    MOVE 2 TO WS-A   MOVE 5 TO WS-B   MOVE "-" TO WS-OP
    MOVE -3 TO WS-ATTENDU  MOVE 0 TO WS-CODE-ATTENDU
    PERFORM 9000-EXECUTER-TEST

    MOVE "Multiplication 1.5 x 4" TO WS-NOM-TEST
    MOVE 1.5 TO WS-A   MOVE 4 TO WS-B   MOVE "*" TO WS-OP
    MOVE 6 TO WS-ATTENDU   MOVE 0 TO WS-CODE-ATTENDU
    PERFORM 9000-EXECUTER-TEST

    MOVE "Division 7 / 2" TO WS-NOM-TEST
    MOVE 7 TO WS-A   MOVE 2 TO WS-B   MOVE "/" TO WS-OP
    MOVE 3.5 TO WS-ATTENDU   MOVE 0 TO WS-CODE-ATTENDU
    PERFORM 9000-EXECUTER-TEST

    MOVE "Division par zero" TO WS-NOM-TEST
    MOVE 7 TO WS-A   MOVE 0 TO WS-B   MOVE "/" TO WS-OP
    MOVE 0 TO WS-ATTENDU   MOVE 1 TO WS-CODE-ATTENDU
    PERFORM 9000-EXECUTER-TEST

    MOVE "Operateur inconnu" TO WS-NOM-TEST
    MOVE 7 TO WS-A   MOVE 2 TO WS-B   MOVE "?" TO WS-OP
    MOVE 0 TO WS-ATTENDU   MOVE 2 TO WS-CODE-ATTENDU
    PERFORM 9000-EXECUTER-TEST

    DISPLAY "-----------------------------------"
    DISPLAY "Tests : " WS-NB-TESTS "  Echecs : " WS-NB-ECHECS
    IF WS-NB-ECHECS > 0
        MOVE 1 TO RETURN-CODE
    END-IF
    STOP RUN.

9000-EXECUTER-TEST.
    ADD 1 TO WS-NB-TESTS
    CALL "CALC" USING WS-A WS-B WS-OP WS-RES WS-CODE
    IF WS-RES = WS-ATTENDU AND WS-CODE = WS-CODE-ATTENDU
        DISPLAY "[ OK  ] " WS-NOM-TEST
    ELSE
        DISPLAY "[ECHEC] " WS-NOM-TEST " resultat=" WS-RES " code=" WS-CODE
        ADD 1 TO WS-NB-ECHECS
    END-IF.
