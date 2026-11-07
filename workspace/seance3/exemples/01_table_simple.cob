*> ---------------------------------------------------------------
*> Exemple 3.1 : table à une dimension (OCCURS) et parcours
*> Les indices COBOL commencent à 1 (pas à 0).
*> ---------------------------------------------------------------
IDENTIFICATION DIVISION.
PROGRAM-ID. TABLE01.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 WS-TABLE-NOTES.
   05 WS-NOTE     PIC 99V9  OCCURS 5 TIMES.
01 WS-I           PIC 99.
01 WS-SOMME       PIC 9(4)V9  VALUE 0.
01 WS-MOYENNE     PIC 99V99.
01 WS-ED-NOTE     PIC Z9.9.
01 WS-ED-MOY      PIC Z9.99.

PROCEDURE DIVISION.
    MOVE 12.5 TO WS-NOTE(1)
    MOVE 15.0 TO WS-NOTE(2)
    MOVE  9.5 TO WS-NOTE(3)
    MOVE 18.0 TO WS-NOTE(4)
    MOVE 11.0 TO WS-NOTE(5)

    PERFORM VARYING WS-I FROM 1 BY 1 UNTIL WS-I > 5
        MOVE WS-NOTE(WS-I) TO WS-ED-NOTE
        DISPLAY "Note " WS-I " : " WS-ED-NOTE
        ADD WS-NOTE(WS-I) TO WS-SOMME
    END-PERFORM

    COMPUTE WS-MOYENNE = WS-SOMME / 5
    MOVE WS-MOYENNE TO WS-ED-MOY
    DISPLAY "Moyenne : " WS-ED-MOY
    STOP RUN.
